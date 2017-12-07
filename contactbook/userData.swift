//
//  userData.swift
//  contactbook
//
//  Created by 小関千晴 on 2017/11/17.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import Foundation

struct userData {
    
    var childID:String
    var grade:String
    var name:String
    
    init(childId:String,grade:String,name:String) {
        self.childID = ""
        self.grade = ""
        self.name = ""
    }
}
extension UserDefaults {
}
