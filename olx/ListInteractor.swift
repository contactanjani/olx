//
//  ListInteractor.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation

private let kLocation = "www.olx.com.ar"
public let kPageSize = "30"

class ListInteractor : ListInteractorInput {
    
    var output : ListInteractorOutput?
    let dataManager : ListDataManager
    
    init(dataManager: ListDataManager) {
        self.dataManager = dataManager
    }
    
    func findResultsForInitialView() {
        self.dataManager.productsFromDataStore { (list) in
            self.output?.foundProductsForInitialView(list)
        }
    }
    
    func findResultsForKeyword(query : String) {
        
        self.dataManager.productsForSearchQuery(query, location: kLocation, pageSize: kPageSize, offSet: nil, completion: { products in
            self.output?.foundProductsForQuery(query, products: products)
        })
    }
    
    func findResultsForKeyword(_ query : String, offSet : String) {
        self.dataManager.productsForSearchQuery(query, location: kLocation, pageSize: kPageSize, offSet: offSet, completion: { products in
            self.output?.foundProductsForQueryWithOffset(offSet, query: query, products: products)
        })
    }
    
    func productWithId(id: String) {
        self.dataManager.fetchProductWithID(id, completion: { product in
            guard let product = product else {
                return
            }
            self.output?.foundProductForId(product)
        })
    }
}
