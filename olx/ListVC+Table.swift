//
//  ListVC+Table.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

extension ListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.populateNextPageDataIfRequired(indexPath.row)
        
        if let cell = mainTableView?.dequeueReusableCell(withIdentifier: ListCellIdentifier) as? ListViewCell {
            
            if tableView == self.mainTableView {
                if let displayItem = dataProperty?.products?[indexPath.row] {
                    cell.updateWithData(displayItem: displayItem)
                    return cell
                }
            }else if tableView == self.searchTableView {
                if let displayItem = searchDataProperty?.products?[indexPath.row] {
                    cell.updateWithData(displayItem: displayItem)
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.mainTableView {
            guard dataProperty != nil, dataProperty?.products != nil else {
                return 0
            }
            return (dataProperty?.products!.count)!
        }else if tableView == self.searchTableView {
            guard searchDataProperty != nil, searchDataProperty?.products != nil else {
                return 0
            }
            return (searchDataProperty?.products!.count)!
        }else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.searchTableView {
            
            tableView.deselectRow(at: indexPath, animated: true)
            if let productDisplayItem = self.searchDataProperty?.products?[indexPath.row] {
                self.eventHandler?.productTapped(displayProduct: productDisplayItem)
            }
        }else if tableView == self.mainTableView {
            if let productDisplayItem = self.dataProperty?.products?[indexPath.row] {
                self.eventHandler?.productTapped(displayProduct: productDisplayItem)
            }
        }
        
    }
    
    func populateNextPageDataIfRequired(_ index : Int) {
        
        guard self.searchDataProperty != nil else {
            return
        }
        let query = self.searchDisplayController?.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let count = (self.searchDataProperty?.products?.count)!
        if  count >= Int(kPageSize)! && ((index + Int(kPageSize)!) > count) {
            self.eventHandler?.updateViewWithResultsAtOffset(query!, offset:count)
        }
    }
}
