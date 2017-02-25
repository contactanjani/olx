//
//  ListViewCell.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

class ListViewCell : UITableViewCell {
    
    @IBOutlet weak var imgViewProduct: CustomImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var productDisplayItem : ProductDisplayItem?
    
    func updateWithData(displayItem : ProductDisplayItem) {
        
        self.productDisplayItem = displayItem
        self.clearCell()
        self.updateView()
    }
    
    func clearCell() {
        self.imgViewProduct.image = nil
        self.imgViewProduct.placeHolderImage = nil
        self.lblTitle.text = nil
        self.lblPrice.text = nil
    }
    
    func updateView() {
        
        if productDisplayItem?.imageUrl != nil {
            self.imgViewProduct.setImageFromString(productDisplayItem?.imageUrl)
        }
        
        if productDisplayItem?.title != nil {
            self.lblTitle.text = productDisplayItem?.title
        }
        
        if productDisplayItem?.price != nil {
            self.lblPrice.text = productDisplayItem?.price
        }
    }
}
