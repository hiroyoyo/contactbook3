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
    var child_id:String="2017002"
    
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.themeLbl.text = "test"
        cell.stampImg.image = #imageLiteral(resourceName: "NEKO完")
        return cell
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        let urlStr = "https://electric-contact-book-swill.c9users.io/stampApi.php"
        if let url = URL(string: urlStr + child_id){
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
