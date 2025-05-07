//
//  TextIconItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

// MARK: - WelcomeElement
struct InsuranceInfoItem: Codable {
    let header, title, subtitle: String
    let grid: [GridDatum]
    let list: [String]
}

// MARK: - Grid
struct GridDatum: Codable {
    let title, subtitle: String
}
