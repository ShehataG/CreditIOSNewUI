//  FaceVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import LocalAuthentication
import KeychainSwift

@MainActor var servicesStatusItem:ServicesStatusItem?

@MainActor
final class ServicesStatusVM : MainObservable {
    @Published var done = false
    var vehicleItems = [MainTypeItem]()
    var medicalItems = [MainTypeItem]()
    override init() {
        super.init()
        Task { @MainActor in
            if let res = servicesStatusItem {
                await assignValues(res)
            }
            else {
                await getConfigs()
            }
        }
    }
    func getConfigs() async {
        Task {
            let (result,error) = await JSONPlaceholderService.getAllActiveCompaniesServices.request(type: ServicesStatusItem.self)
            switch result {
                case .success(let result):
                    print(result)
                    Task {
                        await assignValues(ServicesStatusItem(ezhalha: true, mojaz: true, sweater: true, sanar: true))
                    }
                    break
                case .failure(_):
                    if let error = error {
                        print(error)
                    }
                    break
            }
        }
    }
    func assignValues(_ result:ServicesStatusItem) async {
        servicesStatusItem = result
        vehicleItems = vehicleCreation()
        medicalItems = medicalCreation()
        done = true
    }
    func vehicleCreation()->[MainTypeItem] {
        guard let values = servicesStatusItem?.asDictionary as? [String:Bool] else { return [] }
        let sweater = values["sweater"] ?? false
        let mojaz = values["mojaz"] ?? false
        let ezhalha = values["ezhalha"] ?? false
        return [
            MainTypeItem(key:"sweater",backImage: "wash", frontImage: "washSmall", title: "CarWash", desc: "Sweater",discount: "35%",isActive: sweater),
//            MainTypeItem(backImage: "satha", frontImage: "roadSmall", title: "SathaServices", desc: "Ezhelha"),
            MainTypeItem(key:"mojaz",backImage: "mojaz", frontImage: "mojazSmall", title: "Service", desc: "Mojaz",isActive: mojaz),
            MainTypeItem(key:"ezhelhaBattery",backImage: "battery", frontImage: "roadSmall", title: "BatteryServices", desc: "Ezhelha",isActive: ezhalha),
            MainTypeItem(key:"ezhelhaTire",backImage: "cover", frontImage: "roadSmall", title: "TireServices", desc: "Ezhelha",isActive: ezhalha),
                //        MainTypeItem(backImage: "maintenance", frontImage: "maintenanceSmall", title: "CarMaintenance", desc: "Mesmar"),
                //        MainTypeItem(backImage: "road", frontImage: "roadSmall", title: "HelpOnRoad", desc: "Ezhelha")
        ].filter { $0.isActive }
    }
    func medicalCreation()->[MainTypeItem] {
        guard let values = servicesStatusItem?.asDictionary as? [String:Bool] else { return [] }
        let sanar = values["sanar"] ?? false
        return [
            MainTypeItem(key:"sanar",backImage: "sanarbook",frontImage:"sanarlogo", title: "HealthServices", desc: "Sanar",isActive: sanar),
            MainTypeItem(key:"sanar",backImage: "sanarappoin",frontImage:"sanarlogo", title: "Appointments", desc: "Sanar",isActive: sanar),
        ].filter { $0.isActive }
    }
}
