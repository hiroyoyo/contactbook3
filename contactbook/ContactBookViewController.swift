//
//  ContactBookTvc.swift
//  contactbook
//
//  Created by ryota on 2017/12/21.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class ContactBookViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var contacHst:Array<ContactBookItem>=[]
    var useDefauls = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
//        search()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print(useDefauls.contactBookLogDataArray.count)
        return useDefauls.contactBookLogDataArray.count
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)

        

        cell.textLabel!.text = useDefauls.contactBookLogDataArray[indexPath.row].text
        print("1")
        return cell
    }
    
    
    
//    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
//        // [indexPath.row] から画像名を探し、UImage を設定
//        selectedImage = UIImage(named: imgArray[indexPath.row] as! String)
//        if selectedImage != nil {
//            // SubViewController へ遷移するために Segue を呼び出す
//            performSegue(withIdentifier: "toSubViewController",sender: nil)
//        }
    

    func search(){
        let session = URLSession.shared
        //APIのURL
        let urlStr = "https://electric-contact-book-swill.c9users.io/API/contactBookGetApi.php?child_id="
        if let url = URL(string: urlStr + Stamp.childrenGrade){
            let request = URLRequest(url: url)
            //リクエストを送信
            let task =  session.dataTask(with: request, completionHandler: self.onResponse)
            task.resume()
        }
    }

    func onResponse(data:Data?, response:URLResponse?, error:Error?){
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

            
            contacHst.append(ContactBookItem(dateSet: result["date"]!, textSet: result["text"]!))
            
           
            
        }
        useDefauls.contactBookLogDataArray = contacHst.reversed()


        //tableviewの更新
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    }
    
}

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


