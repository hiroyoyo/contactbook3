//
//  HomeViewController.swift
//  contactbook
//
//  Created by 佐野浩代 on 2017/09/06.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tabBarController?.tabBar.barTintColor = UIColor.white
        self.tabBarController?.tabBar.isTranslucent = true
        
        //日付をラベルに表示
        dateLabel.text = getToday()
    
    }

    //日付を取得
    @IBOutlet weak var dateLabel: UILabel!
    func getToday(format:String = "yyyy年MM月dd日") -> String {

        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
        
        
        
    }

    //アラートボタンがクリックされた時の実装
    @IBAction func tapAlertButton(_ sender: Any) {
    
        //コントローラーの実装
        let alertController = UIAlertController(title: "ログアウトしますか",message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        //ログアウトボタンの実装
        let okAction = UIAlertAction(title: "ログアウト", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            //ログアウトがクリックされた時の処理
            print("ログアウト")
            // ログアウト処理
            //　NCMBUser.logOut()
        }
        //キャンセルボタンの実装
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: nil)
        
        //ボタンに追加
        alertController.addAction(okAction)
        //キャンセルボタンの追加
        alertController.addAction(cancelButton)
        
        //アラートの表示
        present(alertController,animated: true,completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
