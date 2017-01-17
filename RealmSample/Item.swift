//
//  Item.swift
//  RealmSample
//
//  Created by n00877 on 2017/01/17.
//  Copyright © 2017年 Sample. All rights reserved.
//

import RealmSwift

class Item: Object{
    // 品名
    dynamic var name: String? = nil
    // 金額
    dynamic var price = 0
    // 登録日時
    dynamic var created = Date()
}
