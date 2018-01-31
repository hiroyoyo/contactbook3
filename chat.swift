//
//  chat.swift
//  contactBook
//
//  Created by ryota on 2017/07/12.
//  Copyright © 2017年 小関千晴. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase
import FirebaseDatabase


class chat: JSQMessagesViewController {

    
    let sendUser = "福本"
    var messages: [JSQMessage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        senderDisplayName = sendUser
        senderId = sendUser
        navigationItem.title="もも組"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 244/255, green: 249/255, blue: 238/255, alpha: 1)
        initImageView()

        
        
        let ref = Database.database().reference()
        ref.observe(.value, with: { snapshot in
            guard let dic = snapshot.value as?
                Dictionary<String, AnyObject> else {
                return
            }
            
            guard let post = dic["talks"] as?
                Dictionary<String, Dictionary<String, AnyObject>> else {
                return
            }
            
            guard let posts = post[self.sendUser] as?
                Dictionary<String, Dictionary<String, AnyObject>> else {
                return
            }
            
            var keyValueArray: [(String, Int)] = []
            for (key, value) in posts {
                keyValueArray.append((key: key, date: value["date"] as! Int))
            }
            keyValueArray.sort{$0.1 < $1.1}
            
            
            var preMessages = [JSQMessage]()
            for sortedTuple in keyValueArray {
                for (key, value) in posts {
                    if key == sortedTuple.0 {           // 揃えた順番通りにメッセージを作成
                        let senderId = value["senderId"] as! String!
                        let text = value["text"] as! String!
                        let displayName = value["displayName"] as! String!

                        let dateUnix = value["date"] as! TimeInterval
                        let date = NSDate(timeIntervalSince1970: dateUnix/1000) //ミリ秒まで記録されているので1000で割って変換
                        let formatter = DateFormatter() // NSDate型を日時文字列に変換するためのNSDateFormatterを生成
                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let dateStr: String = formatter.string(from: date as Date)

                        let date_formatter: DateFormatter = DateFormatter()
                        date_formatter.locale     = NSLocale(localeIdentifier: "ja") as Locale//日本時間に設定
                        date_formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let jpDate = date_formatter.date(from: dateStr)//StringからDateに変換
                  
    
                        preMessages.append(JSQMessage(senderId: senderId,
                                                   displayName: displayName,
                                                          date: jpDate,
                                                          text: text))
                       
                    }
                }
            }

            // This is a beta feature that mostly works but to make things more stable it is diabled.
           
            
            
            self.messages = preMessages
            
            self.collectionView.reloadData()
            
            //最新欄に移動
            let indexPath = IndexPath(row: self.messages.endIndex-1, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.bottom, animated: false)
            
        }
        )
    }
    private func initImageView(){
        // UIImage インスタンスの生成
        // 画像はAssetsに入れてないのとjpgなので拡張子を入れます
        let image1:UIImage = UIImage(named:"line.png")!
        
        // UIImageView 初期化
        let imageView = UIImageView(image:image1)
        
        // 画面の横幅を取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        // 画像の中心を画面の中心に設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        imageView.contentMode = UIViewContentMode.redraw
        // UIImageViewのインスタンスをビューに追加
        
        self.view.sendSubview(toBack: imageView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //        let imgBackground:UIImageView = UIImageView(frame: self.view.bounds)
        //        imgBackground.image = #imageLiteral(resourceName: "NEKO")
        //        imgBackground.contentMode = UIViewContentMode.scaleAspectFill
        //        imgBackground.clipsToBounds = true
        //        self.collectionView?.backgroundView = imgBackground
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView,
                                 attributedTextForCellTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        
        let message = self.messages[indexPath.item]
        if indexPath.item == 0 {
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
        }
        
        if indexPath.item -  1 > 0{
            let previousMessage = self.messages[indexPath.item - 1 ]
            
            if  ( ( message.date.timeIntervalSince(previousMessage.date) / 60 ) > 1){
                return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
            }
        }
        
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView,
                                 layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout,
                                 heightForCellTopLabelAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.item == 0 {
            
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        
        if indexPath.item -  1 > 0{
            let message = self.messages[indexPath.item]
            let previousMessage = self.messages[indexPath.item - 1 ]
            
            if  ( ( message.date.timeIntervalSince(previousMessage.date) / 60 ) > 1){
                return kJSQMessagesCollectionViewCellLabelHeightDefault
            }
        }
        return 0.0
    }
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,
                                 messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.row]
    }
    
    // コメントの背景色の指定
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,
                                 messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        if messages[indexPath.row].senderId == senderId {
            return JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor(red: 112/255, green: 192/255, blue:  75/255, alpha: 1))
        } else {
            return JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1))
        }
    }
    
    // コメントの文字色の指定
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        if messages[indexPath.row].senderId == senderId {
            cell.textView.textColor = UIColor.white
        } else {
            cell.textView.textColor = UIColor.darkGray
        }
        return cell
    }
    
    
    // メッセージの数
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    // ユーザのアバターの設定
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,
                                 avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(
            withUserInitials: messages[indexPath.row].senderDisplayName,
            backgroundColor: UIColor.lightGray,
            textColor: UIColor.white,
            font: UIFont.systemFont(ofSize: 10),
            diameter: 30)
    }
    // 送信ボタンを押した時の処理
    override func didPressSend(_ button: UIButton!,
                   withMessageText text: String!,
                               senderId: String!,
                      senderDisplayName: String!,
                                   date: Date!) {
        inputToolbar.contentView.textView.text = ""
        let ref = Database.database().reference()
        ref.child("talks").child(senderId).childByAutoId().setValue(["senderId": senderId,
                                                                         "text": text,
                                                                  "displayName": senderDisplayName,
                                                                  "date":[".sv": "timestamp"]])
        button.isEnabled = false
        self.view.endEditing(true)
    }

}
