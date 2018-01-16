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
    override func viewDidLoad() {
        super.viewDidLoad()
        TextView.text = selectedText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
