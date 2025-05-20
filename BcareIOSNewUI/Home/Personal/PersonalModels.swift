//
//  PersonalModels.swift.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI

class CompareContainerItem {
    let image:String
    let header:[CompareItem]
    let top:[CompareItem]
    let bottom:[CompareItem]
    var isExpanded:Bool
    init(image: String, header: [CompareItem], top: [CompareItem], bottom: [CompareItem], isExpanded: Bool = true) {
        self.image = image
        self.header = header
        self.top = top
        self.bottom = bottom
        self.isExpanded = isExpanded
    }
}

struct CompareItem {
    let title,subTitle:String
}

