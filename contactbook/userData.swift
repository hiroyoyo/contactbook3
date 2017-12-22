//
//  userData.swift
//  contactbook
//
//  Created by 小関千晴 on 2017/11/17.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit

class userData:NSObject {
    
    var childID:String
    var grade:String
    var name:String
    
    init(setChildId:String,setGrade:String,setName:String) {
        self.childID = setChildId
        self.grade = setGrade
        self.name = setName
    }
}

//var UserData = [userData]()

