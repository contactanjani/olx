//
//  ManagedProduct.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import CoreData

class ManagedProduct : NSManagedObject {
    @NSManaged var imageUrl : String
    @NSManaged var title : String
    @NSManaged var price : String
    @NSManaged var identifier : String
    
    @NSManaged var fullImageURL : String
    @NSManaged var displayLocation : String
    @NSManaged var discription : String
    
}
