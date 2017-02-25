//
//  AppDependencies.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    var listWireframe = ListWireframe()
    var coreDataStore = CoreDataStore.sharedInstance
    
    init() {
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        listWireframe.presentListInterfaceFromWindow(window)
    }
    
    func configureDependencies() {
        
        let rootWireframe = RootWireframe()
        
        let listPresenter = ListPresenter()
        let listDataManager = ListDataManager()
        let listInteractor = ListInteractor(dataManager: listDataManager)
        
        let detailWireframe = DetailWireframe()
        let detailPresenter = DetailPresenter()
        
        listInteractor.output = listPresenter
        
        listPresenter.listInteractor = listInteractor
        listPresenter.listWireframe = listWireframe
        
        listWireframe.detailWireframe = detailWireframe
        listWireframe.listPresenter = listPresenter
        listWireframe.rootWireframe = rootWireframe
        
        listDataManager.coreDataStore = coreDataStore
        detailWireframe.detailPresenter = detailPresenter
        detailPresenter.detailWireframe = detailWireframe
    }
}
