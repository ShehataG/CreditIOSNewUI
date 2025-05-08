//
//  ViewFactory.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

@MainActor
class ViewFactory {
    @ViewBuilder
    static func viewForDestination(_ destination: Destination) -> some View {
        switch destination {
            case .homePage:
                ContentView()
            case .loginPage:
                LoginView()
            case .registerPage:
                RegisterView()
            case .boardingPage:
                SplashPagesView()
            case  .permissionsPage:
                SplashPermissionsView()
            case .forgetPasswordPage:
                ForgetPasswordView()
            case .medicalProvidersPage:
                MedicalProvidersView()
            case .medicalMenuPage:
                MedicalMenuView()
            case .AddCarPage:
                AddCarView()
            case .mojazPage:
                MojazView()
            case .allPoliciesPage:
                AllPoliciesView()
            case .sweaterBookingsPage:
                BookingListView(items: nil)
            case .ezhelhaBookingsPage:
                OrdersListView(item: nil)
        }
    }
}
