//
//  Stamp.swift
//  contactbook
//
//  Created by ryota on 2017/09/25.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class Stamp: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var stampBtn: UIButton!
    var text1:String = ""
    
    let systemBlueColor = UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        stampBtn.layer.borderWidth = 2.0
        stampBtn.layer.borderColor = UIColor.black.cgColor
        stampBtn.layer.cornerRadius = 10.0
        
        stampBtn.setTitleColor(systemBlueColor, for: .normal)

        
        
    }

    override func viewWillLayoutSubviews() {
        if text1 != ""{
            let img:UIImage = UIImage(named:text1)!
            stampBtn.setImage(img, for: .normal)
            stampBtn.setTitle("", for: .normal)
        }

        super.viewWillLayoutSubviews()
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