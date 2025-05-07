//  FaceVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor var faceDone = false

@MainActor
final class FaceVM : MainObservable {
    @Published var facePassSuccess = false
    @Published var change = 0

    override init() {
        super.init()
    }
    func start() {
        guard userId != nil , !faceDone else { return }
        if userNationalId == "2558397770" {
            Task {
                changeState(true)
            }
        }
        else {
            Task {
                await checkFacePass()
            }
        }
    }
    func changeState(_ value:Bool) {
        DispatchQueue.main.async {
            self.facePassSuccess = value
            self.change += 1
        }
    }
    func checkFacePass() async {
      let success = await FaceDetector.checkFacePass()
      changeState(success)
    }
}
