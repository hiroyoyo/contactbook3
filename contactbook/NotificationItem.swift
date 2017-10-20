//
//  NotificationItem.swift
//  contactbook
//
//  Created by 佐野浩代 on 2017/10/19.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import Foundation

public class Item{
    //投稿日・タイトル・テキスト(とりあえずStringにしてる)
    private var date: String = ""
    private var title:String = ""
    private var text: String = ""
    
//    public init (date:String, title:String, text:String){
//        self.date = date
//        self.title = title
//        self.text = text
//    }
    
    public func getDate() -> String{
        return self.date
    }
    
    public func getTitle() -> String{
        return self.title
    }
    
    public func getText() -> String{
        return self.text
    }
    
    public func setDate(date:String) {
        self.date = date
    }
    
    public func setTitle(title:String) {
        self.title = title
    }
    
    public func setText(text:String) {
        self.text = text
    }
}
