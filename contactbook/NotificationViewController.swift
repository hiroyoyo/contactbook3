//

//  NotificationViewController.swift

//  contactbook

//

//  Created by 佐野浩代 on 2017/09/20.

//  Copyright © 2017年 佐野浩代. All rights reserved.

//



import UIKit



class NotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var grade="0"
    var NoficationItemList:Array<NotificationItem> = []
    var useDefauls = UserDefaults.standard
    
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
        
        search()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
