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
    static var goalId:String = ""
    var date:String = ""
    var info:String = ""
    var useDefauls = UserDefaults.standard
    static var childrenGrade :String = "4"
    
    
    
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
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        
        let now = Date()
      
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-01"
        let dateString = dateFomatter.string(from: now)
    
        
      
        
        if (useDefauls.persistentDomain(forName: "stampDt")) != nil{
            if useDefauls.persistentDomain(forName: "stampDt")?["date"]as? String == dateString{

                if useDefauls.persistentDomain(forName: "stampDt")?["date"]as? String == dateString  {
                    print(useDefauls.persistentDomain(forName: "stampDt")?["img"]as?String! as Any)
                    if (useDefauls.object(forKey: "stampString")) != nil{
                        let img = UIImage(named:(useDefauls.object(forKey: "stampString") as! String))
                        stampBtn.setImage(img, for: .normal)
                        print(img as Any)
                        print("1")
                    }
                    themeLbl.text = useDefauls.persistentDomain(forName: "stampDt")?["info"]as? String
                    print(useDefauls.persistentDomain(forName: "stampDt")?["img"]as?String as Any)
                    print("入ってる")
                    
                }
                
                print(dateString)
            }else{
                print("月が変わってる")
                //月が変わっている
                useDefauls.removeObject(forKey: "stampString")
                search()
                
            }
        }else{
            print("データなし")
            //ユーザーデフォルトなし
            search()
           
        }
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
 
    func search(){
        let session = URLSession.shared
        //APIのURL
        let urlStr = "https://electric-contact-book-swill.c9users.io/API/stampGetApi.php?grade="
        if let url = URL(string: urlStr + Stamp.childrenGrade){
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
        
        for val in src {
            let result = val as! [String:String]
            Stamp.goalId = result["goal_id"]!
            date = result["date"]!
            info = result["info"]!
            
            
            
            DispatchQueue.main.async {
                self.themeLbl.text =  self.info
            }
            
        }
        //tableviewの更新
        saveData(senddate: date, sendinfo: info,setgoal: Stamp.goalId)
    }
    func saveData(senddate: String,sendinfo : String,setgoal:String){
        
        // Keyを指定して保存
        
        useDefauls.setPersistentDomain(["date":senddate,"info":sendinfo,"goal_id":setgoal], forName: "stampDt")
        useDefauls.synchronize()
        
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
