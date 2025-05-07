////
////  InsuranceStore.swift
////  BcareIOSNewUI
////
////  Created by Ahmed Mahmoud on 5/20/24.
////
//
//import Foundation
//import SwiftUI
// 
//struct InsuranceStore {
//    static func getData(_ type:InsuranceType)-> InsuranceInfoItem {
//        let path = Bundle.main.path(forResource: "CarData\(langText)", ofType: "json")!
//        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//        let res = try! JSONDecoder().decode([InsuranceInfoItem].self, from: data)
//        return res[type.rawValue]
//     }
//}
