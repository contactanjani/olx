//
//  ListModuleInterface.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation

protocol ListModuleInterface {
    func updateView()
    func updateViewWithSearchQuery(_ query : String)
    func productTapped(displayProduct : ProductDisplayItem)
    func updateViewWithResultsAtOffset(_ query : String, offset : Int)
}
