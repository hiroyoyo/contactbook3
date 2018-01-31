//
//  HistoryUserDefault.swift
//  contactbook
//
//  Created by ryota on 2017/11/16.
//  Copyright © 2017年 佐野浩代. All rights reserved.
//

import UIKit
extension UserDefaults {
    var stampLogDataArray:[StampHistoryItem]{
        set(datas){
            // Swiftのオブジェクトを、NSObjectなオブジェクトに変換する
            let newDatas:[NSDictionary] = datas.map{
                ["date":$0.date,
                 "info":$0.info,
                 "img":$0.img] as NSDictionary
            }
            // NSObjectなオブジェクトのみになったから、setObjectできる
            self.set(newDatas,forKey:"stampitems")
        }
        get{
            // NSDictionaryの配列として、データを取得
            let datas = self.object(forKey: "stampitems") as? [NSDictionary] ?? []
            // 保存されたデータから復元出来無い場合もあり得るので、
            // mapではなくreduceを使う
            let array = datas.reduce([]){ (ary, d:NSDictionary) -> [StampHistoryItem] in
                // dateやmessageがnilでないなら、MyLogDataを作って足し込む
                if let date = d["date"] as? String,let info = d["info"] as? String,
                let img = d["img"] as? String {
                    return ary + [StampHistoryItem(imgSet: img, infoSet: info, dateSet: date)]
                }else{
                    return ary
                }
            }
            return array
        }
    }
}





