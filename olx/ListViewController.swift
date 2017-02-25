//
//  MainSearchViewController.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

let ListCellIdentifier = "productcell"

class ListViewController : UITableViewController, ListViewInterface {

    var eventHandler : ListModuleInterface?
    var dataProperty : DisplayData?
    var searchDataProperty : DisplayData?
    
    var mainTableView : UITableView?
    var searchTableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView = self.tableView
        self.searchTableView = self.searchDisplayController?.searchResultsTableView
        self.eventHandler?.updateView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.searchDisplayController?.setActive(false, animated: false)
        self.eventHandler?.updateView()
    }
    
    func updateTitle(_ title: String) {
        self.title = title
    }
    
    func showFetchedDisplayDataForQuery(_ query: String, data: DisplayData) {
         
        if self.searchDisplayController?.searchBar.text?.trimmingCharacters(in:.whitespacesAndNewlines) == query {
            print("updated")
            DispatchQueue.main.async {
                self.searchDataProperty = data
                self.searchTableView?.reloadData()
            }
        }else {
            print("not upadted")
        }
    }
    
    func showFetchedInitialDisplayData(_ data: DisplayData) {
        
        DispatchQueue.main.async {
            self.dataProperty = data
            self.mainTableView?.reloadData()
        }
    }
    
    func updateListWithPaginatedData(_query : String, data : DisplayData) {
        
        guard searchDataProperty != nil, data.products != nil, (data.products?.count)! > 0 else {
            return
        }
        
        DispatchQueue.main.async {
            
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                
            }
            let oldCount = (self.searchDataProperty?.products?.count)!
            let newCount = (self.searchDataProperty?.products?.count)! + (data.products?.count)!
            
            var indexPaths = [IndexPath]()
            for indx in oldCount ..< newCount {
                indexPaths.append(IndexPath(row: indx, section: 0))
            }
            
            self.searchTableView?.beginUpdates()
            
            for productDisplayItem in data.products! {
                self.searchDataProperty?.products?.append(productDisplayItem)
            }
            self.searchTableView?.insertRows(at: indexPaths, with: .none)
            self.searchTableView?.endUpdates()
            CATransaction.commit()
        }
    }
    
    func resetSearchTable() {
        self.searchDataProperty = nil
        self.searchTableView?.reloadData()
    }
    
    func showNoContentMessage() {
        
    }
}
