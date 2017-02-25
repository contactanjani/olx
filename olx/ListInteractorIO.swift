//
//  ListInteractorIO.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation

protocol ListInteractorInput {
    func findResultsForKeyword(query : String)
    func findResultsForInitialView()
    func productWithId(id : String)
    func findResultsForKeyword(_ query : String, offSet : String)
}

protocol ListInteractorOutput {
    
    func foundProductsForQuery(_ query : String, products: [Product]?)
    func foundProductsForQueryWithOffset(_ offset : String, query : String, products: [Product]?)
    func foundProductsForInitialView(_ products: [Product]?)
    func foundProductForId(_ product : Product)
}
