//
//  Item.swift
//  RealmSample
//
//  Created by n00877 on 2017/01/17.
//  Copyright © 2017年 Sample. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    // 品名
    @objc dynamic var name: String? = nil
    // 金額
    @objc dynamic var price = 0
    // 登録日時
    @objc dynamic var created = Date()
}
