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
    static var child_id:String="2017002"
    var stampHst:[StampHistoryItem]=[]
    
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stampHst.count
    }
    
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let reversedStampHst:[StampHistoryItem] = stampHst.reversed()
        for _ in 0..<reversedStampHst.count{
            if reversedStampHst.count > 0{
                cell.stampImg.image = UIImage(named:reversedStampHst[indexPath.row].img)
                print(reversedStampHst[indexPath.row].img)
//            cell.stampImg.image=UIImage(named:stampHst[indexPath.row)
                cell.themeLbl.text = reversedStampHst[indexPath.row].info
                print(reversedStampHst[0])
                return cell
            }
        }
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search()
        // Do any additional setup after loading the view.
        
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
            
            let stampHistoryItem = StampHistoryItem(imgSet: result["stamp"]!, infoSet: result["info"]!, dateSet: result["date"]!)
//            stampHistoryItem.info = result["info"]!
//            stampHistoryItem.date = result["date"]!
//            stampHistoryItem.img = result["stamp"]!
            stampHst.append(stampHistoryItem)
//            stampArray=result
//            tableView(table, cellForRowAt: src)
        }
        DispatchQueue.main.async {
            self.table.reloadData()
        }
        print("________________")
        print((stampHst[0]).img)
//        print(test.img)
        //tableviewの更新
//        contactbook.StampHistoryItem.childID
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
