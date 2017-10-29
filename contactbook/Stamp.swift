//
//  Stamp.swift
//  contactbook
//
//  Created by ryota on 2017/09/25.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class Stamp: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var stampBtn: UIButton!
    @IBOutlet weak var themeLbl: UILabel!
    var text1:String = ""
    var text2:String!
    var childrenGrade :String = "4"
    override func viewDidLoad() {
        super.viewDidLoad()
        stampBtn.layer.borderWidth = 2.0
        stampBtn.layer.borderColor = UIColor.black.cgColor
        stampBtn.layer.cornerRadius = 10.0

        
        
        historyBtn.layer.borderWidth = 1.0
        historyBtn.layer.borderColor = UIColor.black.cgColor
        historyBtn.layer.cornerRadius = 10.0
        

        
        themeLbl.numberOfLines = 0 //折り返し
        themeLbl.sizeToFit()
        themeLbl.lineBreakMode = NSLineBreakMode.byCharWrapping
        
        search()
       
    }

    override func viewWillLayoutSubviews() {
        
        if text1 != ""{
            let img:UIImage = UIImage(named:text1)!

            stampBtn.setImage(img, for: .normal)
            stampBtn.titleLabel?.text = ""
          
        }
       

        super.viewWillLayoutSubviews()
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func search(){
        let session = URLSession.shared
        //APIのURL
        let urlStr = "https://electric-contact-book-swill.c9users.io/stampApi.php?grade="
        if let url = URL(string: urlStr + childrenGrade){
            print(urlStr)
            let request = URLRequest(url: url)
            //リクエストを送信
            let task =  session.dataTask(with: request, completionHandler: self.onResponse)
            task.resume()
        }
    }
    
    func onResponse(data:Data?, response:URLResponse?, error:Error?)
    {
        //データが存在するかチェック
        guard let data = data else{
            print("データなし")
            return
        }
        //JSON型からDictionary型に変換
        guard let jsonData = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String:String]] else{
            return
        }
        
        //データの解析
        self.parseData(src: jsonData)
    }
    func parseData(src:[Any]){
        //キー”forecastsの値を取得”
        print(src)
        for val in src {
            let result = val as! [String:String]
            print(result["info"] as Any )
            DispatchQueue.main.async {
                self.themeLbl.text = result["info"]
            }
        }
        //tableviewの更新
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
