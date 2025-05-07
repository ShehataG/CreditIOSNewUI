//
//  BatteryTireItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation

struct BatteryTireItem: Codable {
    let status: Bool
    let message: String?
    let data: BatteryBridgeDatum
}

struct BatteryBridgeDatum: Codable {
    let data: [BatteryDatum]
}
// MARK: - Datum
struct BatteryDatum: Codable {
   let id: Int
   let title, description, price: String
   let oldPrice: Int
   let orderForOthers, schedulable, increasable: String
   let providerMainService, providerCategory: Provider
   let mainCategory: MainCategory
   let estimatedTime: Int
   enum CodingKeys: String, CodingKey {
       case id, title, description, price
       case oldPrice = "old_price"
       case orderForOthers = "order_for_others"
       case schedulable, increasable
       case providerMainService = "provider_main_service"
       case providerCategory = "provider_category"
       case mainCategory = "main_category"
       case estimatedTime = "estimated_time"
   }
}

// MARK: - MainCategory
struct MainCategory: Codable {
    let id: Int
    let title, type: String
    let image: String?
    let selection: String
}

// MARK: - Provider
struct Provider: Codable {
    let id: Int
    let title: String
    let selection: String
    let img: String
}
