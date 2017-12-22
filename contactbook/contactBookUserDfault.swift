//
//  contactBookUserDfault.swift
//  contactbook
//
//  Created by ryota on 2017/12/22.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit
extension UserDefaults {
    var contactBookLogDataArray:[ContactBookItem]{
        set(datas){
            // Swiftのオブジェクトを、NSObjectなオブジェクトに変換する
            let newDatas:[NSDictionary] = datas.map{
                ["date":$0.date,
                 "text":$0.text] as NSDictionary
            }
            // NSObjectなオブジェクトのみになったから、setObjectできる
            self.set(newDatas,forKey:"items")
        }
        get{
            // NSDictionaryの配列として、データを取得
            let datas = self.object(forKey: "items") as? [NSDictionary] ?? []
            // 保存されたデータから復元出来無い場合もあり得るので、
            // mapではなくreduceを使う
            let array = datas.reduce([]){ (ary, d:NSDictionary) -> [ContactBookItem] in
                // dateやmessageがnilでないなら、MyLogDataを作って足し込む
                if let date = d["date"] as? String,let text = d["text"] as? String {
                    return ary + [ContactBookItem(dateSet: date,textSet:text)]
                }else{
                    return ary
                }
            }
            return array
        }
    }
}
