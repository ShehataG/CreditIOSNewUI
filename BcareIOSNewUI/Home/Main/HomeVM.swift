//
//  BookingVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation
import SanarKit

@MainActor var policiesG = [PoliciesResult]()

@MainActor
final class HomeVM : MainObservable {
    @Published var submitLoadingPolicies = false
    @Published var policies = [PoliciesResult]()
    override init()  {
        super.init() 
        Task {
           await start()
        }
    }
    func start() async {
        if policiesG.isEmpty {
            await getAllUserActivePolicies()
        }
        else {
            policies = policiesG
            submitLoadingPolicies = false
        }
    }
    func getAllUserActivePolicies() async {
        guard UserManager.isLoggedIn() , let nin = userNationalId else { return }
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String:String] = [
            "nin": nin // "2570500435"-2529504074"-"1051859500"-"2267833206"
        ]
        Task {
            submitLoadingPolicies = true
            let (result,error) = await JSONPlaceholderService.getAllUserActivePolicies.request(type: PoliciesItem.self,parameters: parameters)
            self.submitLoadingPolicies = false
            switch result {
            case .success(let res):
                print(res)
                if res.errorCode == 1 {
                    self.policies = res.result
                    policiesG = res.result
                    NotificationCenter.default.post(name: .policyCountNotification, object: nil)
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
