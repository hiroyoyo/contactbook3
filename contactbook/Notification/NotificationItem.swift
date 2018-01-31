//
//  NotificationItem.swift
//  contactbook
//
//  Created by 佐野浩代 on 2017/10/19.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import Foundation

public class NotificationItem{
    //投稿日・タイトル・テキスト(とりあえずStringにしてる)
    var date: String = ""
    var title:String = ""
    var text: String = ""
    
    init(dateSet:String,titleSet:String,textSet:String){
        self.date = dateSet
        self.title = titleSet
        self.text = textSet
    }

    
    
}
