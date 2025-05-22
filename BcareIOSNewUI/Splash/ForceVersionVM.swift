//
//  ForceVersionVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
 
@MainActor
final class ForceVersionVM: ObservableObject {
    @Published var showUpdateAlert = false
    var version:VersionItem?
    init() {
        //checkVersion()
    }
    func checkVersion() {
        Task {
            let parameters = [
                "platform" : "ios"
            ]
            let (result,_) = await JSONPlaceholderService.version.request(type: VersionItem.self,parameters:parameters)
            switch result {
            case .success(let result):
                print(result)
                let remote = result.version
                let local = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
                if remote.compare(local, options: .numeric) == .orderedDescending {
                        self.version = result
                        self.showUpdateAlert = true
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    func navigate()  {
        if let url = version?.url {
            if let res = URL(string: url) {
                UIApplication.shared.open(res, options: [:], completionHandler: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showUpdateAlert = true
                }
            }
        }
    }
}
