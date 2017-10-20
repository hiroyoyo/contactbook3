//
//  loginViewController.swift
//  contactbook
//
//  Created by 小関千晴 on 2017/10/18.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit
import Foundation
//import SwiftyJSON

class loginViewController: UIViewController {
   
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
        password.sha1()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //URLを指定してオブジェクトを作成
        let urlStr = "https://electric-contact-book-swill.c9users.io/loginapi.php"
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        
        //コンフィグを指定してHTTPセションを生成
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate:nil, delegateQueue: OperationQueue.main)
        
        //HTTP通信を実行する
        // ※dataにJSONデータが入る
        let task:URLSessionDataTask = session.dataTask(with: request, completionHandler: {data, responce,error in
            
            //エラーがあったら出力
            if error != nil {
                print(error!)
                print("えらーだよーーーーーーーん")
                return
            }
            DispatchQueue.main.async {
                
                //データ取得後の処理
                print("\(data)")
                print("ああああああああああああああああああああああああああああああああああああああ")
                
            }
        })
        //HTTP通信を実行
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func getJson() {
//        let urlStr = "https://electric-contact-book-swill.c9users.io/loginapi.php"
//        if let url = URL(string: urlStr) {
//            let request = URLRequest(url: url)
//            //リクエストを送信
//            let task = session.dataTask(with: request, CompletionHander: self.onResponse)
//            task.resume()
//        }
//    }
    
//    func onResponse(data:Data?, respose:URLResponse?, error:Error?) {
//        //データが存在するかチェック
//        guard let data = data else {
//            print("データなし")
//            return
//        }
//        //JSON型からDictionary型に変換
//        guard let jsonData = try! JSONSerialization.jsonObject(with:data, options: JSONSerialization.ReadingOptions.allowFragments) as?  [String: Any] else {
//            return
//        }
//        //データの解析
//        self.parseData(src: jsonData)
//    }
    
//    func parseData(src:[String: Any]) {
//        let item = Item()
//
//        let id = ["id"] as! String
//        item.setData(id: id)
//
//        let password = ["password"] as! String
//        item.setData(password: password)
//
//        let id = ["name"] as! String
//        item.setData(name: name)
//
//        self.itemList.append(item)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension String {
    // 文字列の SHA-1 ダイジェストを得る
    func sha1() -> String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_SHA1(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        
        return String(hash)
    }
}
