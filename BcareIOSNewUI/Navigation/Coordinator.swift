//
//  Coordinator.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import NavigationStackBackport

class Coordinator: ObservableObject {
//    @Published var path: NavigationPath = .init()
    @Published var path = NavigationStackBackport.NavigationPath()
    @Published var rootViewId = UUID()
    @Published var layoutDirection:LayoutDirection = isAr ? .rightToLeft : .leftToRight
    
    func pop(_ number:Int = 1) {
        path.removeLast(number)
    }
    func goToRoot() {
        path = .init()
    }
    func resetToPage<T:Hashable>(_ destination:T) {
        path = .init()
        path.append(destination)
    }
    func goToHome() {
        path.removeLast(path.count - 1)
    }
    func push<T:Hashable>(_ destination:T) {
        path.append(destination)
    }
    func updateLayoutDirection() {
        layoutDirection = isAr ? .rightToLeft : .leftToRight
    }
    func changeLang() {
        currentKey = isAr ? "en" : "ar"
        languageBundle = Bundle(path: Bundle.main.path (forResource:currentKey, ofType: "lproj")!)
        NotificationCenter.default.post(name: .sanarLangNotification, object: nil)
        reset()
    }
    func reset() {
        updateLayoutDirection()
        rootViewId = UUID()
    }
}
