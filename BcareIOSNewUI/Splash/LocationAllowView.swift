//
//  LocationAllowView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import SwiftUI
import CoreLocation
import SwiftUIPager
import Combine
import SwiftUI

struct LocationAllowView: View {
    @EnvironmentObject var coordinator: Coordinator
    let locationManager = CLLocationManager()
    @State var showingLocationAlert = false
    let lottieSize:CGFloat = isIpad ? 150.0 : 100.0
    @State var lottAnimatedDone = false
    @Binding var page: Page
    var body: some View {
        VStack(spacing:0) {
            VStack {
                HStack {
                    Text(verbatim:"Skip".localized)
                        .font(Fonts.smallRegular())
                        .foregroundColor(Color.black)
                        .onTapGesture {
                            withAnimation {
                                page = Page.withIndex(2)
                            }
                        }
                    Spacer()
                }
                .padding(.horizontal,20)
                Spacer()
                VStack(spacing:5)  {
                    LottieView(lottieFile: "Location", loopMode: .loop, lottAnimatedDone: $lottAnimatedDone)
                        .frame(width: lottieSize,height: lottieSize)
                    GrayText(text:"NeedsLocation".localized)
                        .font(Fonts.mediumRegular())
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal,20)
                Spacer()
                RoundedBu(item: "LocateMe", textColor: .white, backColor: appBlueColor, width: 0.8,vPadding: 15)
                    .onTapGesture {
                        LocationSingleton.shared.startUpdatingLocation()
                    }
            }
        }
        .onReceive(.locationNotification) { _ in
            withAnimation {
                page = Page.withIndex(2)
            }
        }
    }
}

extension Notification.Name {
    static let locationNotification = Notification.Name("LocationAccessed")
}
