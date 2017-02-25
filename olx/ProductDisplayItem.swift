//
//  ProductDisplayItem.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation

class ProductDisplayItem {
    
    var id : String?
    let imageUrl : String?
    let title : String?
    let price : String?
    
    init(product : Product) {
        self.id = product.id
        self.imageUrl = product.thumbnailURL
        self.title = product.title
        self.price = product.price
    }
}
