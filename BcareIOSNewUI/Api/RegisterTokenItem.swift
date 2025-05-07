//
//  RegisterTokenItem.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 27/05/2024.
//

import Foundation
  
struct RegisterTokenItem: Codable {
    var message: String
    var code: Int
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case code = "ErrorCode"
    }
}

struct ServicesStatusItem: Codable {
    let ezhalha, mojaz, sweater, sanar: Bool
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
            guard let label = label else { return nil }
            return (label, value)
        }).compactMap { $0 })
        return dict
    }
}
