//
//  DictionaryExtensions.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/30/24.
//

import Foundation

extension Dictionary {
    func toQueryStringParams() -> String {
        return self
            .map({(key, value) in "\(key)=\(value)"})
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        
    }
}
