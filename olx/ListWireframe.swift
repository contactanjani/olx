//
//  ListWireframe.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

let ListViewControllerIdentifier = "ListViewController"

class ListWireframe {
    
    var detailWireframe : DetailWireframe?
    var listPresenter : ListPresenter?
    var rootWireframe : RootWireframe?
    var listViewController : ListViewController?
    
    func presentListInterfaceFromWindow(_ window: UIWindow) {
        let viewController = listViewControllerFromStoryboard()
        viewController.eventHandler = listPresenter
        listViewController = viewController
        listPresenter!.userInterface = viewController
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func showDetailInterfaceForProduct(product : Product) {
        detailWireframe?.showDetailInterfaceFromNavigationController((self.listViewController?.navigationController)!, product: product)
    }
    
    func listViewControllerFromStoryboard() -> ListViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ListViewControllerIdentifier) as! ListViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }

    
}
