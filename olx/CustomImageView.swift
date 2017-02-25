//
//  CustomImageView.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    var placeHolderImage: String? = "placeholder" // Place holder image name in resources or ImageAssest
    var animate = true
    var cacheType: ImageCacheType = .fileSystemCache
    
    fileprivate var currentImageUrl = ""
    
    func setImageFromString(_ imageUrl: String?) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        configureView()
        
        if imageUrl == nil {
            return
        }
        
        let encodedURL  =  imageUrl!.removingPercentEncoding
        
        self.currentImageUrl  =  encodedURL!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        self.loadAndSetImage(self.currentImageUrl, size: self.bounds.size)
    }
    
    func configureView() {
        
        self.contentMode = UIViewContentMode.center
        
        if placeHolderImage != nil {
            self.image = UIImage(named: placeHolderImage!)
        } else {
            self.image = nil
        }
    }
    
    fileprivate func loadAndSetImage(_ imageUrl: String, size: CGSize) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            
            ImageCache.instance.getImage(imageUrl, size: size, cacheType: self.cacheType, completion: { (image: UIImage?) -> Void in
                
                DispatchQueue.main.async {
                    if(image != nil && imageUrl == self.currentImageUrl) {
                        self.contentMode = .scaleAspectFit
                        self.image = image
                        if self.animate == true {
                            let transition = CATransition()
                            transition.duration = 0.2
                            transition.type = kCATransitionFade
                            self.layer.add(transition, forKey: nil)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false

                        }
                    }
                }
                
            })
        }
    }
}
