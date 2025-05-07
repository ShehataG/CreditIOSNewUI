//
//  BatteryTireVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

@MainActor
final class BatteryTireVM : MainObservable {
    @Published var submitServicesLoading = false
    @Published var services = [BatteryDatum]()
    @Published var selectedIndex = -1
    @Published var showLocationPicker = false
    @Published var address:String?
    @Published var coordinate:CLLocationCoordinate2D?
    @Published var mapId = 0
    @Published var header = ""
    
    override init() {
        super.init()
    }
    func partnerServices(_ id:Int) {
        header = id == 6 ? "BatteryServices".localized : "TireServices".localized
        let parameters:[String:Any] = [
            "id":id,
        ]
        Task {
            submitServicesLoading = true
            let (result,error) = await JSONPlaceholderService.mainService.request(type: BatteryTireItem.self,parameters: parameters)
            self.submitServicesLoading = false
            switch result {
            case .success(let res):
                print(res)
                 if res.status {
                    let content = res.data.data.reversed()
                    self.services = Array(content)
                }
                break
            case .failure(_):
                if let error = error {
                    print(error)
                    self.showError(error.description)
                }
                break
            }
        }
    }
}
