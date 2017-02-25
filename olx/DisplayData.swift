//
//  DisplayData.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation

struct DisplayData  {
    var products : [ProductDisplayItem]?
    
    init(_ list : [ProductDisplayItem]?) {
        products = list
    }
}
