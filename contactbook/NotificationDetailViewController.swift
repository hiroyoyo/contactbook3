//
//  NotificationDetailViewController.swift
//  contactbook
//
//  Created by 佐野浩代 on 2017/10/19.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class NotificationDetailViewController: UIViewController{

    //見たい記事がクリックされた時の遷移先の設定
    @IBOutlet weak var UiLabel: UILabel!
    @IBOutlet weak var UiTextView: UITextView!

    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
    
    var item:NotificationItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.UiLabel.text = self.item.title
        self.UiTextView.text = self.item.text

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
