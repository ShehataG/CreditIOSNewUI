//  createGl.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import WebKit

@MainActor
func createGl(_ item:InsuranceType) -> String {
    let arr = [AppURL,MedicalURL,TravelURL,MalpracticesURL]
    let url = arr[item.rawValue]
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    var res = url + "?channel=ios&lang=\(langText)&version=\(version)&firebasetoken=\(FIREBASE_TOKEN ?? "")"
    if let value = userBeginLoginItem , UserManager.isLoggedIn() {
        print(value)
        let data = try!JSONEncoder().encode(value)
        res += "&gl=" + data.base64EncodedString()
        print(res)
        return res
    }
    else {
        print(res)
        WKWebView.clean()
        return res
    }
}
