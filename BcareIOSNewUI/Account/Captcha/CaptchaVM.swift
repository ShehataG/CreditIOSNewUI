//
//  CaptchaVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import LocalAuthentication
import KeychainSwift

@MainActor
final class CaptchaVM : MainObservable {
    @Published var submitLoadingCaptcha = false
    @Published var captchaExpired = false
    @Published var image = ""
    @Published var token = ""
    var expireTime:Int?
    var timer:Timer?
    override init() {
        super.init()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getCaptcha()
        }
    }
    func getCaptcha() {
        if submitLoadingCaptcha {
            return
        }
        if noNetwork() {
            showNoNetwork()
            return
        }
        Task {
            submitLoadingCaptcha = true
            let (result,error) = await JSONPlaceholderService.getCaptcha.request(type: CaptchaItem.self)
            self.submitLoadingCaptcha = false
            switch result {
            case .success(let res):
                self.image = res.data.image
                self.token = res.data.token
                self.captchaExpired = false
                self.expireTime = res.data.expiredInSeconds
                self.restartTimer()
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
    @MainActor
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] t in
            Task {
                await self?.process()
            }
        }
    }
    func process() async {
        if let expireTime = self.expireTime {
            if expireTime > 1 {
                self.expireTime! -= 1
            }
            else {
                self.captchaExpired = true
            }
        }
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    func restartTimer() {
        stopTimer()
        startTimer()
    }
}
