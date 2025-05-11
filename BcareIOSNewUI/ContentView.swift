//
//  ContentView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport
import AdjustSdk


struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var homeVM = HomeVM()
    @State var selectedIndex = 0

    var body: some View {
        VStack(spacing:0) {
            VStack(spacing:0) {
                TabView(selection: $selectedIndex) {
                    HomeView()
                        .tag(0)
                    ProductsView()
                        .tag(1)
                    WareefView()
                        .tag(3)
                    ProfileView()
                        .tag(4)
                }
                .overlay (
                    HStack(spacing: 0) {
                        // MARK: - Tab Button
                        TabItemView(selection: $selectedIndex, tag: 0, systemName: "home", title: "Main")
                        TabItemView(selection: $selectedIndex, tag: 1, systemName: "calculator", title: "Calculator")
                            .offset(x: -10)
                        TabItemView(selection: $selectedIndex, tag: 2, systemName: "plus.circle.fill", title: "Main")
                            .offset(y: -30)
                        TabItemView(selection: $selectedIndex, tag: 3, systemName: "wareef", title: "Wareef")
                            .offset(x: 10)
                        TabItemView(selection: $selectedIndex, tag: 4, systemName: "user", title: "MyAccount")
                    }
                    .background(
                        Color.white
                            .clipShape(CustomCurveShape())
                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                            .ignoresSafeArea(.container, edges: .bottom)
                    )
                , alignment: .bottom )
            }
        }
        .background(Color.clear)
        .navigationBarBackButtonHidden()
        .onOpenURL(perform:handleURL)
        .environmentObject(homeVM)
        .onReceive(.logoutAuthNotification) { _ in
            coordinator.reset()
        }
        .onReceive(.reloadPoliciesNotification) { _ in
            Task {
                await homeVM.getAllUserActivePolicies()
            }
        }
        .onReceive(.changeTabNotification) { notification in
            selectedIndex = notification.object as! Int
        }
        .onFirstAppear {
            isAppOpened = true
            Adjust.trackEvent(ADJEvent(eventToken: "ik8401"))
            requestIDFA()
        }
    }
    func handleURL(_ url: URL) {
        if url.scheme?.localizedCaseInsensitiveCompare(Config.urlScheme) == .orderedSame {
            NotificationCenter.default.post(name: .hyperpayNotification, object: nil)
        }
    }
    func requestIDFA() {
        Task {
            let _ = await ATTrackingManager.requestTrackingAuthorization()
        }
    }
}


struct CustomCurveShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            // MARK: = CURVE CENTER
            let mid = rect.width / 2
            path.move(to: CGPoint(x: mid - 70, y:0))
            let to1 = CGPoint(x: mid, y: 45)
            let control1 = CGPoint(x: mid - 35, y: 0)
            let control2 = CGPoint(x: mid - 35, y: 45)
            path.addCurve(to: to1, control1: control1, control2: control2)
            let to2 = CGPoint(x: mid + 70, y: 0)
            let control3 = CGPoint(x: mid + 35, y: 45)
            let control4 = CGPoint(x: mid + 35, y: 0)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}
