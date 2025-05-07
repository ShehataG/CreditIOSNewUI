////
////  AuthenticatedVM.swift
////  BcareIOSNewUI
////
////  Created by Ahmed Mahmoud on 5/22/24.
////
//
//import Foundation
//import SwiftUI
//import Combine
//import CoreLocation
//import SanarKit
//
//@MainActor
//final class AuthenticatedVM : MainObservable {
//    @Published var submitIsAuthenticated = false
//    @Published var done = false
//    
//    override init() {
//        super.init()
//        Task {
//            await isAuthenticated()
//        }
//    }
//    func isAuthenticated() async {
//        if noNetwork() {
//            showNoNetwork()
//            return
//        }
//        Task {
//            submitIsAuthenticated = true
//            let (result,error) = await JSONPlaceholderService.isAuthenticated.request(type: AuthenticatedItem.self)
//            self.submitIsAuthenticated = false
//            self.done = true
//             switch result {
//            case .success(let res):
//                print(res)
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
//}
