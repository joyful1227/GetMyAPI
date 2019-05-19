//
//  item.swift
//  GetMyAPI
//
//  Created by Joy on 2019/5/18.
//  Copyright © 2019 Joy. All rights reserved.
//

import Foundation



struct ItemData: Codable {
    var data: [Item]
}


struct Item: Codable {
    
    var product_name: String
    var price: String
    var img_url: String
    var category: String
    var description: String
    var date: String //上架日期
}
