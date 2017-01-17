//
//  ViewController.swift
//  RealmSample
//
//  Created by n00877 on 2017/01/17.
//  Copyright © 2017年 Sample. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textPrice: UITextField!
    @IBOutlet weak var table: UITableView!
    
    var itemList: Results<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デフォルトRealmを取得
        let realm = try! Realm()
        // 一覧を取得：金額を条件に、登録日時が新しい順でソート
        self.itemList = realm.objects(Item.self).filter("price > 0").sorted(byProperty: "created", ascending: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /* 追加処理 */
    @IBAction func actionAdd(_ sender: AnyObject) {
        // 入力値をセット
        let item:Item = Item()
        item.name = self.textName.text
        if ((self.textPrice.text?.characters.count)! > 0) {
            item.price = Int(self.textPrice.text!)!
        }
        
        // インサート実行
        let realm = try! Realm()
        try! realm.write {
            realm.add(item)
        }
        
        // クエリの実行結果は自動的に最新の状態に更新される⇒再度取得する必要がない
        //self.itemList = realm.objects(Item.self).filter("price > 0").sorted(byProperty: "created", ascending: true)
        
        // テーブルを再読込
        self.table.reloadData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemListCell = tableView.dequeueReusableCell(withIdentifier: "ItemListCell")! as! ItemListCell
        
        // 行取得
        let item: Item = self.itemList[(indexPath as NSIndexPath).row];
        // 品名
        cell.lblName.text = item.name
        // 金額
        cell.lblPrice.text = self.convert(price: item.price)
        // 登録日時
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd' 'HH:mm:ss"
        cell.lblDate.text = formatter.string(from: item.created)
        
        return cell
    }
    
    func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath) {
    }


    /* 金額表示用に変換 */
    private func convert(price: Int) -> String
    {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.groupingSize = 3
        return "¥"+decimalFormatter.string(from: price as NSNumber)!
    }

}

