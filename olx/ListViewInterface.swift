//
//  ListViewInterface.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation

protocol ListViewInterface {
    func showNoContentMessage()
    func showFetchedDisplayDataForQuery(_ query : String, data: DisplayData)
    func showFetchedInitialDisplayData(_ data: DisplayData)
    func updateListWithPaginatedData(_query : String, data : DisplayData)
    func updateTitle(_ title : String)
    func resetSearchTable()
}
