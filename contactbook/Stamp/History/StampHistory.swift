//
//  stampHistory.swift
//  contactbook
//
//  Created by ryota on 2017/09/25.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class StampHistory: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    static var child_id:String="2013004"
    var stampHst:Array<StampHistoryItem>=[]
    var formatter = DateFormatter()
    var useDefauls = UserDefaults.standard
    let now = Date()
    
    let dateFomatter = DateFormatter()
    
    
    
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useDefauls.stampLogDataArray.count
    }
    
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell

        let reversedStampHst:Array<StampHistoryItem> = useDefauls.stampLogDataArray
        cell.themeLbl.numberOfLines = 0
        for _ in 0..<reversedStampHst.count{
            if reversedStampHst.count > 0{
                print(reversedStampHst[indexPath.row].date)
                cell.stampImg.image = UIImage(named:reversedStampHst[indexPath.row].img)
                cell.themeLbl.text = setDete(setDt: reversedStampHst[indexPath.row].date) + reversedStampHst[indexPath.row].info
                return cell
            }
        }
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        search()
     
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    
    func search(){
        let session = URLSession.shared
        //APIのURL
        let urlStr = "https://electric-contact-book-swill.c9users.io/API/stampHistoryApi.php?child_id="
        if let url = URL(string: urlStr + StampHistory.child_id){
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
      
        
        for val in src {
            
            let result = val as! [String:String]
            
            

            stampHst.append(StampHistoryItem(imgSet: result["stamp"]!, infoSet: result["info"]!, dateSet: result["date"]!))
            
        }
        useDefauls.stampLogDataArray = stampHst.reversed()
        print(useDefauls.stampLogDataArray)
        DispatchQueue.main.async {
            self.table.reloadData()
        }
        
//        print(useDefauls.array(forKey: "DataStore"))
    }

     func setDete(setDt:String) -> String{
        let str : String = setDt
        let offseter = str[..<str.index(str.startIndex, offsetBy: 7)]
        let histMonth = offseter.replacingOccurrences(of:"-", with:"年")
        return histMonth + "月　"
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
