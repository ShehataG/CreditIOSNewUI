//
//  AddCarItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 6/2/24.
//

import Foundation

struct AddCarItem: Codable {
    let id: Int
    let makerNameAr, makerNameEn: String
    let models: [AddCarModel]
    var name: String {
        isAr ? makerNameAr : makerNameEn
    }
}
  
struct AddCarModel: Codable {
    let id: Int
    let modelNameAr, modelNameEn: String
    var name: String {
        isAr ? modelNameAr : modelNameEn
    }
}

struct AddCarResultItem: Codable {
    let success:Bool
    let message: String
}
