//
//  ListVC+Searchbar.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        let oldText = searchText
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: {
            print("old " + oldText)
            print("new " + searchBar.text!)
            
            if oldText == searchBar.text && searchBar.text != nil && searchBar.text != "" {
                print("calling")
                let trimmedSearchText = searchText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                self.eventHandler?.updateViewWithSearchQuery(trimmedSearchText)
            }else {
                print("not calling")
            }
        })
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.eventHandler?.updateView()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchDataProperty = nil
    }
}
