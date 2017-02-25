//
//  DetailWireframe.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

let DetailViewControllerIdentifier = "DetailViewController"

class DetailWireframe {
    
    var detailPresenter : DetailPresenter?
    
    func showDetailInterfaceFromNavigationController(_ navigationController: UINavigationController, product : Product) {
        
        let newViewController = detailViewController()
        newViewController.eventHandler = detailPresenter
        detailPresenter?.configureUserInterfaceForProduct(userInterface: newViewController, product:product)
        navigationController.pushViewController(newViewController, animated: true)
        
    }
    
    func detailViewController() -> DetailViewController {
        let storyboard = mainStoryboard()
        let addViewController: DetailViewController = storyboard.instantiateViewController(withIdentifier: DetailViewControllerIdentifier) as! DetailViewController
        return addViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
}
