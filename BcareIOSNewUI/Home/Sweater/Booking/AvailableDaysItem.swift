//
//  AvailableMainItem.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation

struct AvailableMainItem: Codable {
    let date: String
    let items: [AvailableDaysItem]
}
struct AvailableDaysItem: Codable {
    let date: String
    let slots: [AvailableDaysSlotItem]
}

// MARK: - Slot
struct AvailableDaysSlotItem: Codable {
    let startTime: String

    enum CodingKeys: String, CodingKey {
        case startTime = "start_time"
    }
}
