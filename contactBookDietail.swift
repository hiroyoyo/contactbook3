//
//  contactBookDietail.swift
//  contactbook
//
//  Created by ryota on 2017/12/22.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class contactBookDietail: UIViewController {

    @IBOutlet weak var TextView: UITextView!
    var selectedText:String!
    var selectedId:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextView.text = selectedText
        seter(id: selectedId)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func seter(id:String){
        let session = URLSession.shared
        //APIのURL
        let urlStr = "https://electric-contact-book-swill.c9users.io/API/contactBookSetApi.php"
        let selectData = "?contact_book_id=\(id)"
        print(selectData)
        if let url = URL(string:urlStr + selectData){

            let request = URLRequest(url: url)
            let task =  session.dataTask(with: request)
            
            
            task.resume()
            
        }
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
