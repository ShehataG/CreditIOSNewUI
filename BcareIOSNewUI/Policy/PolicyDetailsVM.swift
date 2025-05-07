//
//  PolicyDetailsVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class PolicyDetailsVM : MainObservable {
//    @Published var medicalDate = "2026/02/05"
//    @Published var item:PolicyResultItem!
//    @Published var submitGetPolicy = true
    
    override init() {
        super.init() 
    }
    
//    func getPolicy(_ policyNo:String) {
//        if noNetwork() {
//            showNoNetwork()
//            return
//        }
//        let parameters:[String:Any] = [
//            "policyNumber": policyNo,
//        ]
//        Task {
//            submitGetPolicy = true
//            let (result,error) = await JSONPlaceholderService.getPolicyDetailsByNumber.request(type:PolicyMainItem.self,parameters: parameters)
//            DispatchQueue.main.async {
//                self.submitGetPolicy = false
//            }
//            switch result {
//            case .success(let res):
//                print(res)
//                if (res.errorCode == 1) {
//                    self.item = res.result
//                }
//                else {
//                    self.showError(res.errorDescription)
//                }
//                break
//            case .failure(_):
//                if let error = error {
//                    print(error)
//                    self.showError(error.description)
//                }
//                break
//            }
//        }
//    }
}
