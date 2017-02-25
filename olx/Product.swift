//
//  Product.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation

class Product {
    
    var id : String? = nil
    var title : String? = nil
    var thumbnailURL : String? = nil
    var price : String? = nil
    
    var fullImageURL : String? = nil
    var displayLocation : String? = nil
    var description : String? =  nil
    
    init(dictionary : [String:Any]) {
     
        if let oID = dictionary["id"] as? Int {
            self.id = String(format:"%d",oID)
        }
        
        if let oThumbNail = dictionary["thumbnail"] as? String {
            self.thumbnailURL = oThumbNail
        }
        
        if let oTitle = dictionary["title"] as? String {
            self.title = oTitle
        }
        
        if (dictionary["price"] != nil ) {
            if (dictionary["price"] is [String:Any?]?) == true {
                let oPriceDictionary = (dictionary["price"] as! [String:Any?]?)
                self.price = oPriceDictionary?["displayPrice"] as! String?
            }else {
                self.price = ""
            }
        }
        
        if let oFullImageURL = dictionary["fullImage"] as? String {
            self.fullImageURL = oFullImageURL
        }
        
        if let oDisplayLocation = dictionary["displayLocation"] as? String {
            self.displayLocation = oDisplayLocation
        }
        
        if let oDescription = dictionary["description"] as? String {
            self.description = oDescription
        }
    }
    
    init(_ managedProduct : ManagedProduct) {
        self.id = managedProduct.identifier
        self.title = managedProduct.title
        self.thumbnailURL = managedProduct.imageUrl
        self.price = managedProduct.price
        self.fullImageURL = managedProduct.fullImageURL
        self.description = managedProduct.discription
        self.displayLocation = managedProduct.displayLocation
    }
}
