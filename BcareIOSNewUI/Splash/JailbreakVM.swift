//
//  JailbreakVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

@MainActor
final class JailbreakVM: ObservableObject {
    @Published var jailbreakStatus = false
    init() {
       jailbreakStatus = getJailbrokenStatus()
    }
    func getJailbrokenStatus() -> Bool {
        #if targetEnvironment(simulator)
            return false
        #else
            // Check 1 : existence of files that are common for jailbroken devices
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app") || FileManager.default.fileExists(atPath:"/Library/MobileSubstrate/MobileSubstrate.dylib")  || FileManager.default.fileExists(atPath:"/bin/bash") || FileManager.default.fileExists(atPath: "/usr/sbin/sshd") || FileManager.default.fileExists(atPath:"/etc/apt") || FileManager.default.fileExists(atPath: "/private/var/lib/apt/") || UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.example.package")!) {
                return true
            }
            // Check 2 : Reading and writing in system directories (sandbox violation)
            let stringToWrite = "Jailbreak Test"
            do {
                try stringToWrite.write(toFile:"/private/JailbreakTest.txt", atomically:true, encoding:String.Encoding.utf8)
                return true
                
            } catch {
                return false
            }
        #endif
    }
}
