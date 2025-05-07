//
//  AddCarVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import MapKit

@MainActor
final class AddCarVM : MainObservable {
    @Published var submitGetVehicles = false
    @Published var submitLoadingDownload = false
    @Published var submitLoadingSave = false
    
    @Published var searchMaker = ""
    @Published var searchModel = ""

    @Published var vinErrorText:String?
    @Published var vin = ""
    
    @Published var makerErrorText:String?
    @Published var maker = ""
    
    @Published var modelErrorText:String?
    @Published var model = ""

    @Published var yearErrorText:String?
    @Published var year = ""
    
    @Published var plateNumberErrorText:String?
    @Published var plateNumber = ""
    
    @Published var plateLettersErrorText:String?
    @Published var plateLetters = ""
    
    @Published var currentMotorVehicles = [AddCarItem]()
    @Published var goBack = false
    @Published var currentMaker:AddCarItem?
    @Published var currentModel:AddCarModel?

    override init() {
        super.init()
        Task {
           await getMotorVehicles()
        }
    }
    func getMotorVehicles() async {
        if let res = motorVehicles {
            currentMotorVehicles = res
            return
        }
        if noNetwork() {
            showNoNetwork()
            return
        }
        Task {
            submitGetVehicles = true
            let (result,error) = await JSONPlaceholderService.getVehiclesInfo.request(type: [AddCarItem].self)
            self.submitGetVehicles = false
            switch result {
            case .success(let result):
                print(result)
                motorVehicles = result
                self.currentMotorVehicles = result
                break
            case .failure(_):
                if let error = error {
                    print(error)
                }
                break
            }
        }
    }
    func addCarManual() {
        guard let nin = userNationalId else { return  }
        if currentMaker == nil {
            makerErrorText = "VehicleMakerRequired".localized
        }
        else {
            makerErrorText = nil
        }
        if currentModel == nil {
            modelErrorText = "VehicleModelRequired".localized
        }
        else {
            modelErrorText = nil
        }
        
        if year == "" {
            yearErrorText = "VehicleYearRequired".localized
        }
        else {
            yearErrorText = nil
        }
        
        let trimmedplateNumber = plateNumber.trimmed().replacedArabicDigitsWithEnglish
        if trimmedplateNumber == "" {
            plateNumberErrorText = "PlateNumberRequired".localized
        }
        else {
            if trimmedplateNumber.isValidPlateNumber() {
                plateNumberErrorText = nil
            }
            else {
                plateNumberErrorText = "PlateNumberIncorrect".localized
            }
        }
        
        let trimmedplateLetters = plateLetters.trimmed()
        if trimmedplateLetters == "" {
            plateLettersErrorText = "PlateLettersRequired".localized
        }
        else {
            if trimmedplateLetters.isValidPlateLetters() {
                plateLettersErrorText = nil
            }
            else {
                plateLettersErrorText = "PlateLettersIncorrect".localized
            }
        }
        
        if makerErrorText != nil || modelErrorText != nil || yearErrorText != nil || plateNumberErrorText != nil || plateLettersErrorText != nil {
            return
        }
        
        if noNetwork() {
            showNoNetwork()
            return
        }
         
        let makerCode = currentMaker!.id
        let modelCode = currentModel!.id
        
        let parameters:[String:Any] = [
            "NationalId": nin,
            "MakerCode": makerCode,
            "ModelCode": modelCode,
            "ManufactureYear": year,
            "PlateNumber": trimmedplateNumber,
            "PlateLetters": trimmedplateLetters
        ]
        Task {
            submitLoadingSave = true
            let (result,error) = await JSONPlaceholderService.addCar.request(type: AddCarResultItem.self,parameters:parameters)
            self.submitLoadingSave = false
            switch result {
            case .success(let result):
                print(result)
                self.complete(result)
                break
            case .failure(_):
                if let error = error {
                    print(error)
                }
                break
            }
        }
    }
    func addCarWithVin() {
        guard let nin = userNationalId else { return  }
        let trimmedVin = vin.trimmed()
        if trimmedVin == "" {
            vinErrorText = "SequenceRequired".localized
        }
        else {
            if trimmedVin.isValidSequence() {
                vinErrorText = nil
            }
            else {
                vinErrorText = "SequenceExceeds".localized
            }
        }
        
        if vinErrorText != nil {
            return
        }
        
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String:Any] = [
            "NationalId": nin,
            "SequenceNumber": trimmedVin,
        ]
        Task {
            submitLoadingDownload = true
            let (result,error) = await JSONPlaceholderService.checkVehiclesBySequenceNumber.request(type:AddCarResultItem.self,parameters:parameters)
            self.submitLoadingDownload = false
            switch result {
            case .success(let result):
                print(result)
                self.complete(result)
                break
            case .failure(_):
                if let error = error {
                    print(error)
                }
                break
            }
        }
    }
    func complete(_ result:AddCarResultItem) {
        if result.success {
            self.showInfo(result.message)
            self.goBack = true
        }
        else {
            self.showError(result.message)
        }
    }
}
