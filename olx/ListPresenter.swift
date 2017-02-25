//
//  ListPresenter.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

class ListPresenter : ListInteractorOutput, ListModuleInterface {
    
    var listInteractor : ListInteractorInput?
    var listWireframe : ListWireframe?
    var userInterface : ListViewInterface?
    
    var isOffsetAPIInProgress = false
    
    func updateView() {
        listInteractor?.findResultsForInitialView()
        self.userInterface?.updateTitle(NSLocalizedString("Search", comment: "title for search page"))
    }
    
    func updateViewWithSearchQuery(_ query : String) {
        self.listInteractor?.findResultsForKeyword(query: query)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func updateViewWithResultsAtOffset(_ query: String, offset: Int) {
        if isOffsetAPIInProgress == false {
            isOffsetAPIInProgress = true
            self.listInteractor?.findResultsForKeyword(query, offSet: String(format:"%d",offset))
        }
    }
    
    func foundProductsForQueryWithOffset(_ offset: String, query: String, products: [Product]?) {
        
        guard products != nil, let products = products else {
            userInterface?.showNoContentMessage()
            return
        }
        var displayItemList = [ProductDisplayItem]()
        for product in products {
            let productDisplayItem = ProductDisplayItem(product: product)
            displayItemList.append(productDisplayItem)
        }
        let displayData = DisplayData(displayItemList)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        self.userInterface?.updateListWithPaginatedData(_query: query, data: displayData)
        self.isOffsetAPIInProgress = false
    }
    
    func foundProductsForQuery(_ query: String, products: [Product]?) {
    
        guard products != nil, let products = products else {
            userInterface?.showNoContentMessage()
            return
        }
        var displayItemList = [ProductDisplayItem]()
        for product in products {
            let productDisplayItem = ProductDisplayItem(product: product)
            displayItemList.append(productDisplayItem)
        }
        let displayData = DisplayData(displayItemList)
        self.userInterface?.showFetchedDisplayDataForQuery(query,data :displayData)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func foundProductsForInitialView(_ products: [Product]?) {
        
        guard products != nil, let products = products else {
            return
        }
        var displayItemList = [ProductDisplayItem]()
        for product in products {
            let productDisplayItem = ProductDisplayItem(product: product)
            displayItemList.append(productDisplayItem)
        }
        let displayData = DisplayData(displayItemList)
        self.userInterface?.showFetchedInitialDisplayData(displayData)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func productTapped(displayProduct : ProductDisplayItem) {
        if let id = displayProduct.id {
            self.listInteractor?.productWithId(id: id)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
    
    func foundProductForId(_ product: Product) {
        self.listWireframe?.showDetailInterfaceForProduct(product: product)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
