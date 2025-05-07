//
//  AppleCardVM.swift
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
final class AppleCardVM : MainObservable {
    @Published var submitGetCard = false
    @Published var showPk = false
    @Published var pass: PKPass? = nil
    override init() {
        super.init()
    }
   
    func getCard(_ item:PoliciesResult)  {
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String:Any] = [
            "userId": userId ?? "",
            "language": item.productID == 2 ? "en" : langText, // Make lanuage en for medical cards
            "channel": "ios",
            "UserActivePoliciesOutput": item.asDictionary
        ]
        Task {
            submitGetCard = true
            let (result,error) = await JSONPlaceholderService.appleCard.getFileData(parameters: parameters)
            self.submitGetCard = false
            switch result {
            case .success(let res):
                print(res)
                do {
                    let pass = try PKPass(data: res)
                    self.pass = pass
                    self.showPk = true
                }
                catch {
                    print("AppleCardIssue: ",error)
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
