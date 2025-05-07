//
//  FaceDetector.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 2/13/25.
//

import LocalAuthentication

class FaceDetector {
    static func checkFacePass() async -> Bool {
        let context = LAContext()
        var error:NSError?
        let policy:LAPolicy = .deviceOwnerAuthenticationWithBiometrics
        if context.canEvaluatePolicy(policy, error: &error) {
            do {
                let success = try await context.evaluatePolicy(policy, localizedReason: "Please Add your touch Id / Passcode")
                return success
            }
            catch {
                return false
            }
         } else {
             return false
        }
    }
}
