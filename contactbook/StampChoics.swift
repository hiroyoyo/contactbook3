//
//  StampChoics.swift
//  contactbook
//
//  Created by ryota on 2017/09/25.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class StampChoics: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate ,UINavigationControllerDelegate{
   
    let photos =  ["icon_1", "icon_2","icon_3","icon_4","icon_5","icon_6","icon_7"]
    var selectedImage: UIImage?
    var choicsBtnImg :String = ""
    
    
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
        
        
      
        
        return Cell
    }
    
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize:CGFloat = self.view.frame.size.width/2-2
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return 7;
    }
    
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
                self.navigationController?.popViewController(animated: true)
                
            })
            

            // キャンセルボタン
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("Cancel")
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
    
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
