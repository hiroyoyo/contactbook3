//

//  NotificationViewController.swift

//  contactbook

//

//  Created by 佐野浩代 on 2017/09/20.

//  Copyright © 2017年 佐野浩代. All rights reserved.

//



import UIKit



class NotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var grade="4"
    var NoficationItemList:Array<NotificationItem> = []
    var useDefauls = UserDefaults.standard
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
    
        
        return useDefauls.notificationLogDataArray.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationTableViewCell
        cell.label.text = ("\(useDefauls.notificationLogDataArray[indexPath.row].date) \(useDefauls.notificationLogDataArray[indexPath.row].title)")
        
        return cell
        
    }
    @objc func refresh(sender: UIRefreshControl) {
        

        
        search()
        //読込中の表示を見るためにあえて2秒スリープする。

        self.refreshControl.endRefreshing()
        //テーブルを再読み込みする。
        tableView.reloadData()
        
        //読込中の表示を消す。
        
    }
    
    func search(){
        
        let session = URLSession.shared
        
        //APIのURL/public/API/notificationapi.php
        
        let urlStr = "https://electric-contact-book-swill.c9users.io/API/notificationapi.php?grade="
        
        if let url = URL(string: urlStr + grade){
            print(url)
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
        guard let jsonData = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as?[[String:Any]] else{
            return
        }
        
        //データの解析
        
        self.parseData(src: jsonData)
        
    }
    
    
    
    func parseData(src:[Any]){
        self.NoficationItemList.removeAll()
        for val in src {
          
            
            let data = val as! [String:String]

            
            self.NoficationItemList.append(NotificationItem(dateSet: data["date"]!, titleSet: data["title"]!, textSet: data["text"]!))
            
        }
        useDefauls.notificationLogDataArray = NoficationItemList.reversed()
        
        
        //tableviewの更新
        
        DispatchQueue.main.async() {
            
            self.tableView.reloadData()
            
        }
        
    }
    
    //表示させたいんす。
    
    func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath)
        
    {
        
        performSegue(withIdentifier: "NotificationDetail", sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        
        
        let vc = segue.destination as! NotificationDetailViewController
        
        let index = sender as! Int
        
        vc.item = useDefauls.notificationLogDataArray[index]
        
    }

    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        search()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(NotificationViewController.refresh(sender:)), for: .valueChanged)
        refreshControl.endRefreshing()
       
    }


    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
