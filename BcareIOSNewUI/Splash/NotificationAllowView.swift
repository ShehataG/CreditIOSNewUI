//
//  NotificationAllowView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import SwiftUI
import CoreLocation
import SwiftUIPager

struct NotificationAllowView: View {
    @EnvironmentObject var coordinator: Coordinator
    let locationManager = CLLocationManager()
    @State var showingLocationAlert = false
    let lottieSize:CGFloat = isIpad ? 150.0 : 100.0
    @State var lottAnimatedDone = false
    var body: some View {
        VStack(spacing:0) {
            VStack {
                HStack {
                    Text(verbatim:"Skip".localized)
                        .font(Fonts.smallRegular())
                        .foregroundColor(Color.black)
                        .onTapGesture {
                            coordinator.push(Destination.boardingPage)
                        }
                    Spacer()
                }
                .padding(.horizontal,20)
                Spacer()
                VStack(spacing:5)  {
                    LottieView(lottieFile: "Notification", loopMode: .loop, lottAnimatedDone: $lottAnimatedDone)
                        .frame(width: lottieSize,height: lottieSize)
                    GrayText(text: "NeedsNotification".localized)
                        .font(Fonts.mediumRegular())
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal,20)
                Spacer()
                RoundedBu(item: "Continue", textColor: .white, backColor: appBlueColor, width: 0.8,vPadding: 15)
                    .onTapGesture {
                        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                        UNUserNotificationCenter.current().requestAuthorization(
                            options: authOptions,
                            completionHandler: { ( willAllow , error) in
                                DispatchQueue.main.async {
                                    coordinator.push(Destination.boardingPage)
                                }
                            })
                    }
            }
        }
    }
}
