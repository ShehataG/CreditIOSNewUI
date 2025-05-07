//
//  SanarVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation
import SanarKit

@MainActor var sanarUserInfo:[AnyHashable:Any]?

@MainActor
final class SanarVM : MainObservable , Sendable {
    @Published var submitUserInfo = false
    @Published var isSanarConnected = false
    @Published var isService = false
    @Published var isBooking = false
    @Published var isConsult = false
    @Published var dId = ""
    @Published var aId = ""

    let token = ": c8NQD9ugZ72FV1dRdFcUypLzhjg7jS4Oymvur33xgo/NPawk+4rDLlLFl5GIW22eaSvMj7wDVWTlSP6tgbk5V4yGSVUBE4ZbI7uHkYUTWWH9XseQb3Ysy+Cfj4V8LytKYYyFWK0w6Iugy1rE0awugz504F7fxw8r5QRmPuf3IOVaowDOhUR53FRxuek73UIiV5YILBBbUFQNlIa0BrdzLdT0leVqU0HwWk9OiE49oXHTYFXcJn/rzQesZfe5i/mb"
    override init() {
        super.init()
    }
    func start() {
        guard !isSanarConnected else { return }
        if let _ = userSanarItem {
            connect()
        }
        else {
            getUserInfo()
        }
    }
    func getUserInfo() {
        guard userId != nil , let nin = userNationalId else { return }
        if noNetwork() {
            showNoNetwork()
            return
        }
        let parameters:[String:Any] = [
            "nin": nin
        ]
        Task {
            submitUserInfo = true
            let (result,error) = await JSONPlaceholderService.getUserDetails.request(type: UserSanarItem.self,parameters: parameters)
            self.submitUserInfo = false
            switch result {
            case .success(let res):
                print(res)
                userSanarItem = res
                self.connect()
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
    func connect() {
        guard let userSanar = userSanarItem,UserManager.isLoggedIn() else { return }
        
//        let clientData: [String: Any] = [
//                "first_name": "John",
//                "last_name": "Doe",
//                "dob": "1990-01-01",
//                "gender": "M",
//                "nationality": "Saudi Arabia",
//                "document_id": "2469433220",
//                "mid": "MG2",
//                "document_type": 1,
//                "phone_code": "91",
//                "phone_no": "81794771111",
//                "maritalStatus": "0"
//            ]
 
        let clientData: [String: Any] = [
            "first_name": UserManager.usernameFirst()!,
            "last_name": UserManager.usernameLast()!,
            "dob": userSanar.dateOfBirth,
            "gender": userSanar.gender, // F
            "nationality": userSanar.getCurrentNationality(),
            "document_id": userNationalId ?? "",
            "mid": userId ?? "",
            "document_type": 1, // 1 is for national , other may be passport
            "phone_code": "966",
            "phone_no": userPhone?.removeZero ?? "",
            "maritalStatus": userSanar.maritalStatus, // 0 is un-married
//            "ipc": "307"
        ]
        Task {
            do {
                print("Sanar Connection data",clientData)
                let success = try await SKManager.connect(
                    cid: token,
                    bundleId: "com.example.demo",
                    clientInfo: clientData,
                    lang: langText // ar or en
                )
                print("Sanar Connected \(success)")
                self.isSanarConnected = true
             } catch {
                print("Sanar Connection Failed: \(error)")
            }
        }
    }
    func disconnect() {
        isSanarConnected = false
        SKManager.disconnect()
        print("Sanar Disconnected")
    }
    func startConsult(_ userInfo:[AnyHashable:Any]?) {
        guard let userInfo = userInfo ,
             let aId = userInfo["aId"] as? String,
             let dId = userInfo["dId"] as? String else { return }
        print("Sanar aId> \(String(describing: aId))")
        print("Sanar dId> \(String(describing: dId))")
        self.dId = dId
        self.aId = aId
        self.isConsult = true
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
