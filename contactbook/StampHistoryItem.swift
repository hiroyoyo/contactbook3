//
//  StampHistoryItem.swift
//  contactbook
//
//  Created by ryota on 2017/11/02.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class StampHistoryItem: NSObject {
    var img:String
    var info:String
    var date:String
    
    init(imgSet:String,infoSet:String,dateSet:String) {
        self.img=imgSet
        self.date=dateSet
        self.info=infoSet
    }
}
