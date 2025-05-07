//
//  GoogleGeocodeItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 6/2/24.
//

import Foundation

// MARK: - Welcome
struct GoogleGeocodeItem: Codable {
    let status:String
    let results: [GoogleGeocodeItemResult]
    // MARK: - Result
    struct GoogleGeocodeItemResult: Codable {
        let formattedAddress: String

        enum CodingKeys: String, CodingKey {
            case formattedAddress = "formatted_address"
        }
    }
}
