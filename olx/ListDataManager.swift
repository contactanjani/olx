//
//  ListDataManager.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation

class ListDataManager {
    var coreDataStore : CoreDataStore?
    
    func productsForSearchQuery(_ query : String, location : String, pageSize : String, offSet : String?, completion : @escaping ((_ productList : [Product]?) -> Void)) {
        
        var parameterString = "searchTerm=\(query)&location=\(location)&pageSize=\(pageSize)"
        if offSet != nil {
            parameterString += "&offset=\(offSet!)"
        }
        
        APIService.sharedInstance.getResultsForSearchWith(parameters: parameterString) {[weak self] (list) -> Void in
            
            guard list != nil else {
                completion(nil)
                return
            }
            let productList = self?.convertToProductFromDictionary(list!)
            
            DispatchQueue.main.async {
                
                if offSet == nil {
                    self?.coreDataStore?.deleteAllProducts()
                }
                
                self?.saveToDataStore(list: productList!)
                completion(productList)
            }
        }
    }
    
    func productsFromDataStore(completion : @escaping ((_ productList : [Product]?) -> Void)) {
        
        coreDataStore?.fetchProductEntries(completionBlock: { list in
            let products = self.convertToProduct(list)
            completion(products)
        })
    }
    
    func fetchProductWithID(_ id : String, completion : @escaping ((_ product : Product?) -> Void)) {
        
        let predicate = NSPredicate(format: "identifier == %@", id as CVarArg)
        coreDataStore?.fetchEntriesWithPredicate(predicate, completionBlock: { entry in
            guard entry != nil else {
                completion(nil)
                return
            }
            
            let product = self.convertToProduct([entry!]).first
            completion(product)
        })
    }
    
    private func saveToDataStore(list : [Product]) {
        DispatchQueue.main.async {
            self.coreDataStore?.save(productList: list)
        }
    }
    
    private func convertToProductFromDictionary(_ list : [[String:Any]]) ->[Product] {
        
        var productList = [Product]()
        for dictionary in list {
            let product = Product(dictionary: dictionary)
            productList.append(product)
        }
        return productList
    }
    
    private func convertToProduct(_ list : [ManagedProduct]) ->[Product] {
        var productList = [Product]()
        for managedProduct in list {
            let product = Product(managedProduct)
            productList.append(product)
        }
        return productList
    }
}
