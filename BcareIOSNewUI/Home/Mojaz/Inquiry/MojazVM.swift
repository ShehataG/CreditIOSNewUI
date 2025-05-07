//
//  MojazVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class MojazVM : MainObservable {
    @Published var submitReportLoading = false
    @Published var mojazResult:MojazResult?
    @Published var showDetails = false
    @Published var vin = ""
    @Published var vinErrorText:String?
    @Published var modelYear = ""
    @Published var modelYearErrorText:String?
    @Published var phone = ""
    @Published var phoneErrorText:String?
    
    override init() {
        super.init()
        Task {
            await setInitValues()
        }
    }
    func setInitValues() {
        #if DEBUG
//            vin = "704599110"
//            modelYear = "2008"
//            phone = "0553837475"
        #endif
    }
    func getReport() {
        if submitReportLoading {
            return
        }
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
        let trimmedPhone = phone.replacedArabicDigitsWithEnglish
        if trimmedPhone == "" {
            phoneErrorText = "PhoneRequired".localized
        }
        else {
            if trimmedPhone.isValidPhone() {
                phoneErrorText = nil
            }
            else {
                phoneErrorText = "PhoneIncorrect".localized
            }
        }
        let trimmedModelYear = modelYear
        if trimmedModelYear == "" {
            modelYearErrorText = "ModelYearٍRequired".localized
        }
        else {
            modelYearErrorText = nil
        }
        if vinErrorText != nil || phoneErrorText != nil || modelYearErrorText != nil {
            return
        }
        let parameters:[String:Any] = [
            "sequenceNumber":trimmedVin,
            "phone":trimmedPhone,
            "modelYear":trimmedModelYear,
            "nationalId":userNationalId!
        ]
        Task {
            submitReportLoading = true
            let (result,error) = await JSONPlaceholderService.mojazInquiry.request(type: MojazItem.self,parameters: parameters)
            self.submitReportLoading = false
            switch result {
            case .success(let res):
                print(res)
                if res.errorDetails.isSuccess {
                    self.mojazResult = res.result
                    self.showDetails = true
                }
                else {
                    self.showError(res.errorDetails.errorDescription)
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
