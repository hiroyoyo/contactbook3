//
//  NotificationViewController.swift
//  contactbook
//
//  Created by 佐野浩代 on 2017/09/20.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var itemList:[String] = []
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
        cell.textLabel?.text = itemList[indexPath.row]
        return cell
    }
        func search(){
            let session = URLSession.shared
            //APIのURL
            let urlStr = "https://electric-contact-book-swill.c9users.io/notificationapi.php"
            if let url = URL(string: urlStr){
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
                print(result["title"])
            }
            //tableviewの更新
            self.tableView.reloadData()
        }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        search()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
}
