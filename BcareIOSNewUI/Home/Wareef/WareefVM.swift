//
//  WareefVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import LocalAuthentication
import KeychainSwift
import PassKit

@MainActor
final class WareefVM : MainObservable {
    @Published var submitMainLoading = false
    @Published var submitSubLoading = false
    @Published var mainItems = [WareefDatumItem]()
    @Published var wareefCache = [Int:[WareefCategoryDatumItem]]()
    @Published var subIndex:Int?
    @Published var wareefLoading = false
    @Published var submitOffersLoading = false
    @Published var expireDate:String? = nil
    @Published var showWareefCard = false
    
    override init() {
        super.init()
    }
    func start() {
        if noNetwork() {
            showNoNetwork()
            return
        }
        self.getCategories()
        self.checkForOffers()
    }
    func getCategories() {
        Task {
            submitMainLoading = true
            let (result,error) = await JSONPlaceholderService.category.request(type: WareefItem.self)
            self.submitMainLoading = false
            switch result {
            case .success(let res):
                self.mainItems = res.data
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
    func loadCategory(_ id:Int) {
        let parameters:[String:Any] =  [
            "id": id
        ]
        if noNetwork() {
            showNoNetwork()
            return
        }
        Task {
            submitSubLoading = true
            let (result,error) = await JSONPlaceholderService.categoryItemByCategoryId.request(type: WareefCategoryItem.self,parameters: parameters)
            self.submitSubLoading = false
            switch result {
            case .success(let res):
                self.wareefCache[id] = res.data
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
    func checkForOffers()  {
        guard UserManager.isLoggedIn() , let nin = userNationalId else { return }
        if let expiry = userWareefExpiryDate , let expiryDate = expiry.toUtcDate() , let current = Date().toUtcDate() {
            print("expiryDateWareef: ",expiryDate)
            print("currentWareef: ",current)
            if current < expiryDate {
                expireDate = processDate(expiry)
                showWareefCard = true
                return
            }
        }
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String:Any] = [
            "Nin": nin,//"1051859500",
            "lang": langText,
            "language": langText,
            "channel": "ios",
        ]
        Task {
            submitOffersLoading = true
            let (result,error) = await JSONPlaceholderService.checkForOffers.request(type: OfferItem.self,parameters: parameters)
            self.submitOffersLoading = false
            switch result {
            case .success(let res):
                print(res)
                if res.errorCode == 1  {
                    if let expireDate = res.result.expiryDate {
                        userWareefExpiryDate = expireDate
                        self.expireDate = self.processDate(expireDate)
                        self.showWareefCard = true
                    }
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
    func processDate(_ str:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if let date = formatter.date(from: str) {
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }
        else {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
            let date = formatter.date(from: str)!
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }
    }
}
