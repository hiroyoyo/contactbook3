//
//  loginViewController.swift
//  contactbook
//
//  Created by 小関千晴 on 2017/10/18.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit
import Foundation

class loginViewController: UIViewController{
    
    var response:String = ""
    var errorCode:String = ""
    var error:String = ""
    var useDefauls = UserDefaults.standard
    var hashPass:String = ""
    var userDefauls = UserDefaults.standard
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    
    var id :String = ""
    
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var passTextField: UITextField!
    
    var password :String = ""
    
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButton(_ sender: Any) {
    
        id = idTextField.text!
        password = passTextField.text!
        
        //パスワードをハッシュ化
        hashPass = md5(password)
        print("\(hashPass)わんこ")
        
        search(id: id,password: hashPass)
    }
    @IBOutlet weak var warning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func search(id:String, password:String) {
        let session = URLSession.shared
        //APIのURL
        let urlStr = "https://electric-contact-book-swill.c9users.io/API/loginapi.php"
        
        print("\(id)")
        print("\(password)ニャンコ")
        
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        //リクエストを送信
        let task = session.dataTask(with: request, completionHandler: self.onResponse)
        task.resume()
    }
    func onResponse(data:Data?, response:URLResponse?,error: Error?) {
        guard  let data = data else {
            print("データなし")
            return
        }
        //JSON型からDictionary型に変換
        guard let jsonData = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String:String]] else {
            
            return
        }
        //データの解析
        self.parseData(src: jsonData)
}
    func parseData(src:[Any]){
        //キー"forcastsの値を取得"
        print(src)
        for val in src {
            let result = val as! [String:String]
            response = result["response"]!
            print(response)
            errorCode = result["errorCode"]!
            print(errorCode)
            error = result["error"]!
            print(error)
        }
//        ホームでユーザーデフォルトに値が入ってるか確認して
//        入ってなかったらログインの方の画面に移る
        errorCheck(response: response,errorCode: errorCode)
    }
    //エラーだったらラベルに警告を表示
    //エラーじゃなかったらホーム画面に遷移する関数
    func errorCheck(response:String,errorCode:String) {
        if(response == "login_ok"){
            
            //ユーザデフォルトにログイン許可したことを保存する
            saveData()
            
            
            print("ログイン成功しました")
            DispatchQueue.global(qos: .default).async {
                // サブスレッド(バックグラウンド)で実行する方を書く
                DispatchQueue.main.async {
                    // Main Threadで実行する
                    //ホーム画面に遷移
                    let storyboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                    let nextView = storyboard.instantiateInitialViewController()
                    self.present(nextView!, animated: true, completion: nil)
                }
            }
        } else if(errorCode == "100002") {
            //ラベルにidまたはpasswordが一致しなかったことをラベルに表示
            DispatchQueue.main.async {
                self.warning.text = "idまたはpasswordが間違っています。"
            }
        } else if(errorCode == "100000"){
            //情報自体が取れなかったことをラベルに表示
            DispatchQueue.main.async {
                self.warning.text = "コンテントが取得できません。"
            }
        } else {
            DispatchQueue.main.async {
                self.warning.text = "何らかのエラー"
            }
        }
    }
    func saveData() {
        //Keyを指定して保存ユーザーデフォルトに追加
        UserDefaults.standard.set(true, forKey: "login_ok")
        
        
        if UserDefaults.standard.object(forKey: "login_ok") != nil {
            print("値が存在しておりまする")
        }
        print("ユーザデフォルト設定完了しました")
    }
}
func md5(_ string: String) -> String {
    var md5String = ""
    let digestLength = Int(CC_MD5_DIGEST_LENGTH)
    let md5Buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: digestLength)
    
    if let data = string.data(using: .utf8) {
        data.withUnsafeBytes({ (bytes: UnsafePointer<CChar>) -> Void in
            CC_MD5(bytes, CC_LONG(data.count), md5Buffer)
            md5String = (0..<digestLength).reduce("") { $0 + String(format:"%02x", md5Buffer[$1]) }
        })
    }
    return md5String
}
