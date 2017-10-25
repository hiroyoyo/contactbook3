//
//  Stamp.swift
//  contactbook
//
//  Created by ryota on 2017/09/25.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class Stamp: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var stampBtn: UIButton!
    @IBOutlet weak var themeLbl: UILabel!
    var text1:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stampBtn.layer.borderWidth = 2.0
        stampBtn.layer.borderColor = UIColor.black.cgColor
        stampBtn.layer.cornerRadius = 10.0

        
        
        historyBtn.layer.borderWidth = 1.0
        historyBtn.layer.borderColor = UIColor.black.cgColor
        historyBtn.layer.cornerRadius = 10.0
        
        themeLbl.text = "本を５冊よめたらスタンプを押そう!!"
        
        themeLbl.numberOfLines = 0 //折り返し
        themeLbl.sizeToFit()
        themeLbl.lineBreakMode = NSLineBreakMode.byCharWrapping
        
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
