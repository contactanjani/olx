//
//  DetailPresenter.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation

class DetailPresenter : DetailModuleInterface {
    
    var detailWireframe : DetailWireframe?
    
    func configureUserInterfaceForProduct(userInterface : DetailViewInterface, product : Product) {
        userInterface.updateTitle(NSLocalizedString("Details", comment: "product details page title"))
        let displayData = DetailDisplayData(product: product)
        userInterface.updateWithDisplayData(detail: displayData)
    }
}
