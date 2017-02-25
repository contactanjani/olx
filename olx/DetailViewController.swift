//
//  DetailViewController.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController : UIViewController, DetailViewInterface {
    
    var eventHandler : DetailModuleInterface?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgViewProduct: CustomImageView!
    
    var displayData : DetailDisplayData?
    
    func updateWithDisplayData(detail : DetailDisplayData) {
        self.displayData = detail
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureUI()
    }
    
    func configureUI() {
        self.updateView()
    }
    
    func updateView() {
        
        if self.displayData?.product?.fullImageURL != nil {
            self.imgViewProduct.setImageFromString(self.displayData?.product?.fullImageURL)
        }
        
        if self.displayData?.product?.title != nil {
            self.lblTitle.text = self.displayData?.product?.title
        }
        
        if self.displayData?.product?.price != nil {
            self.lblPrice.text = self.displayData?.product?.price
        }
        
        if self.displayData?.product?.description != nil {
            self.lblDescription.text = self.displayData?.product?.description
        }
    }
    
    func updateTitle(_ title: String) {
        self.title = title
    }
}
