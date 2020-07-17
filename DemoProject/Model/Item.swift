//
//  Item.swift
//  DemoProject
//
//  Created by APPLE on 17/07/2020.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class Item: NSObject {
    var id:Int?
    var name:String?
    var itemDescription:String?
    var price:Float?
    var itemRate:Int?
    
    init(item:[String:Any]) {
        if let itemId = item["id"] as? Int{
            self.id = itemId
        }
        
        if let name = item["name"] as? String{
            self.name = name
        }
        
        if let description = item["description"] as? String{
            self.itemDescription = description
        }
        
        if let price = item["price"] as? Float{
            self.price = price
        }
        
        if let itemRate = item["itemRate"] as? Int{
            self.itemRate = itemRate
        }
        
    }
}
