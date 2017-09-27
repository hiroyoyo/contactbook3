//
//  stamp.swift
//  contactbook
//
//  Created by ryota on 2017/09/25.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class stamp: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var stompBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        stompBtn.layer.borderWidth = 2.0
        stompBtn.layer.borderColor = UIColor.black.cgColor
        stompBtn.layer.cornerRadius = 10.0
        // Do any additional setup afer loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func stampAdd(_ sender: Any) {
        
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
