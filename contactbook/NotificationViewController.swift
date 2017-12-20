//

//  NotificationViewController.swift

//  contactbook

//

//  Created by 佐野浩代 on 2017/09/20.

//  Copyright © 2017年 佐野浩代. All rights reserved.

//



import UIKit



class NotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var itemList:[Item] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        let reverseditemLIst:Array<Item> = itemList.reversed()
        
        return reverseditemLIst.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let reverseditemLIst:Array<Item> = itemList.reversed()
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "mycell")
        
        cell.textLabel?.text = reverseditemLIst[indexPath.row].getDate() + " " + reverseditemLIst[indexPath.row].getTitle()
        
        return cell
        
    }
    
    func search(){
        
        let session = URLSession.shared
        
        //APIのURL/public/API/notificationapi.php
        
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
        
        guard let jsonData = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any] else{
            
            
            
            return
            
        }
        
        
        
        print("---------------------")
        
        print(jsonData)
        
        //データの解析
        
        self.parseData(src: jsonData)
        
    }
    
    
    
    func parseData(src:[Any]){
        
        for val in src {
            
            let item:Item = Item()
            
            let data = val as! [String:String]
            
            item.setDate(date: data["date"]!)
            
            item.setTitle(title: data["title"]!)
            
            item.setText(text: data["text"]!)
            
            self.itemList.append(item)
            
        }
        
        
        
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
    
    
    
    //降順に表示されるようになっております
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let reverseditemLIst:Array<Item> = itemList.reversed()
        
        let vc = segue.destination as! NotificationDetailViewController
        
        let index = sender as! Int
        
        vc.item = reverseditemLIst[index]
        
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
