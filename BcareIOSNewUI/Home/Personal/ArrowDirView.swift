//
//  ArrowDirView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SVGKit

struct ArrowDirView: View {
    let isExpanded:Bool
    var body: some View {
        FAText(text:isExpanded ? FontAwesome.arrowUpIcon : FontAwesome.arrowDownIcon,font:Fonts.fontAwesome15_20())
            .padding(5)
            .background(appGreenColor)
            .clipShape(Circle())
    }
}
