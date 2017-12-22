//
//  ContactBookItem.swift
//  contactbook
//
//  Created by ryota on 2017/12/21.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class ContactBookItem: NSObject {
    var date:String
    var text:String
    
    init(dateSet:String,textSet:String) {

        self.date=dateSet
        self.text=textSet
        
    }
}
