//
//  StampChoics.swift
//  contactbook
//
//  Created by ryota on 2017/09/25.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class StampChoics: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate ,UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout{
   
    let photos =  ["NEKO", "OINU","USAGI","RAION"]
    var selectedImage: UIImage?
    var choicsBtnImg :String = ""
    let linePoint: CGFloat = 5     // 罫線の太さ
    let numberOfCols: CGFloat = 3  // 1行に表示するセルの数
    var useDefauls = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // Cell はストーリーボードで設定したセルのID
        let Cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath )
        
        // Tag番号を使ってImageViewのインスタンス生成
        let imageView = Cell.contentView.viewWithTag(1) as! UIImageView
        // 画像配列の番号で指定された要素の名前の画像をUIImageとする
        let cellImage = UIImage(named:photos[(indexPath as NSIndexPath).row])
        // UIImageをUIImageViewのimageとして設定
        imageView.image = cellImage
        Cell.clipsToBounds = true
        Cell.layer.cornerRadius = 8.0
      
        
        return Cell
    }
    
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // [indexPath.row] から画像名を探し、UImage を設定
        selectedImage = UIImage(named: photos[(indexPath as NSIndexPath).row])
        if selectedImage != nil {
            print(photos[(indexPath as NSIndexPath).row])
            choicsBtnImg = photos[(indexPath as NSIndexPath).row]
            // SubViewController へ遷移するために Segue を呼び出す
            let alert: UIAlertController = UIAlertController(title: "確認", message: photos[(indexPath as NSIndexPath).row]+"を押しますか？", preferredStyle:  UIAlertControllerStyle.actionSheet)
            
            // ② Actionの設定
            // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
            // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
            // OKボタン
            let defaultAction: UIAlertAction = UIAlertAction(title: "押す", style: .default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
                self.choicsBtnImg =  self.photos[(indexPath as NSIndexPath).row]
                self.useDefauls.set(self.photos[(indexPath as NSIndexPath).row], forKey: "stampString")
                self.navigationController?.popViewController(animated: true)
                self.seter()
               
            })
            

            // キャンセルボタン
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("Cancel")
                self.choicsBtnImg = ""
            })
            
            // ③ UIAlertControllerにActionを追加
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            
            // ④ Alertを表示
            present(alert, animated: true, completion: nil)
        }
        
    }
  



   func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    
        if let controller = viewController as? Stamp {
            
            if choicsBtnImg != ""{
              
                controller.text1 = choicsBtnImg
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = floor((collectionView.frame.size.width - (linePoint*(numberOfCols-1))) / numberOfCols)
        
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return linePoint
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return photos.count
    }

    func seter(){
        let session = URLSession.shared
        //APIのURL
        let urlStr = "https://electric-contact-book-swill.c9users.io/API/stampSetApi.php"
        let selectData = "?goal_id=\(useDefauls.persistentDomain(forName: "stampDt")?["goal_id"]as! String)&child_id=\(StampHistory.child_id)&stamp=\(self.choicsBtnImg)"
        print(selectData)
        if let url = URL(string:urlStr + selectData){
            print(url)
            print("1")
            print(Stamp.goalId)
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
