//
//  DetailViewInterface.swift
//  olx
//
//  Created by Anjani on 2/24/17.
//  Copyright © 2017 do. All rights reserved.
//

import Foundation

protocol DetailViewInterface {
    func updateWithDisplayData(detail : DetailDisplayData)
    func updateTitle(_ title : String)
}
