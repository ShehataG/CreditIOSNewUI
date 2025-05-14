//
//  BcareIOSNewUIApp.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import SwiftUI
import SanarKit
import StoreKit
import NavigationStackBackport
import WebKit
import AudioToolbox
import AppTrackingTransparency

class LottieLoading: ObservableObject {
    @Published var show = false
}

@main
struct BcareIOSNewUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var lottieLoading = LottieLoading()
    @StateObject var coordinator = Coordinator()
    @StateObject var jailbreakVM = JailbreakVM()
    @StateObject var forceVersionVM = ForceVersionVM()
    @StateObject var vpnVm = VpnVm()
    @StateObject var sanarVM = SanarVM()
    @StateObject var faceVM = FaceVM()
    @StateObject var servicesStatusVM = ServicesStatusVM()
    @State var showSplash = true

//    @State var showLog = false
//    @State var statusError = ""
    
    init() {
//        splashPagesShowed = false
        AppDelegate.shared = self.appDelegate
    }
    var body: some Scene {
        WindowGroup {
            ZStack {
                VStack {
                    //                    if statusError != "" && showLog {
                    //                        ScrollView(showsIndicators: false) {
                    //                            ZStack(alignment: .top) {
                    //                                VStack(spacing:10) {
                    //                                    Text(verbatim:"Api <☠️> StatusCode")
                    //                                        .font(Fonts.smallRegular())
                    //                                        .foregroundColor(Color.black)
                    //                                        .multilineTextAlignment(.center)
                    //                                    Text(verbatim:statusError)
                    //                                        .font(Fonts.smallRegular())
                    //                                        .foregroundColor(Color.red)
                    //                                        .multilineTextAlignment(.center)
                    //                                }
                    //                                HStack {
                    //                                    FAText(text: FontAwesome.closeIcon,color: Color.black)
                    //                                        .onTapGesture {
                    //                                            showLog = false
                    //                                        }
                    //                                        .padding(.horizontal,20)
                    //                                    Spacer()
                    //                                }
                    //                            }
                    //                        }
                    //                        .frame(maxWidth: .infinity)
                    //                        .frame(height: 50)
                    //                        .background(Color.white)
                    //                    }
                    if showSplash {
                        NavigationStackBackport.NavigationStack(path: $coordinator.path) {
                            SplashView()
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        if !jailbreakVM.jailbreakStatus , !vpnVm.vpnStatus {
                                            if userId == nil {
                                                self.showSplash = false
                                            }
                                            else {
                                                faceVM.start()
                                            }
                                        }
                                    }
                                }
                                .backport.navigationDestination(for: Destination.self) { value in
                                    ViewFactory.viewForDestination(value)
                                }
                                .preferredColorScheme(.light)
                                .onChange(of: faceVM.change,perform: { _ in
                                    faceDone = faceVM.facePassSuccess
                                    showSplash = false
                                })
                        }
                        .edgesIgnoringSafeArea(.all)
                        .environmentObject(coordinator)
                        .environment(\.layoutDirection, coordinator.layoutDirection)
                        .alert("DeviceJailbroken".localized, isPresented: $jailbreakVM.jailbreakStatus) {
                            Button {
                                exit(0)
                            } label: {
                                Text(verbatim: "OK".localized)
                            }
                        }
                        .alert("DeviceVpn".localized, isPresented: $vpnVm.vpnStatus) {
                            Button {
                                exit(0)
                            } label: {
                                Text(verbatim: "OK".localized)
                            }
                        }
                    }
                    else if !splashPagesShowed {
                        NavigationStackBackport.NavigationStack(path: $coordinator.path) {
                            SplashPagesView()
                                .backport.navigationDestination(for: Destination.self) { value in
                                    ViewFactory.viewForDestination(value)
                                }
                                .preferredColorScheme(.light)
                        }
                        .edgesIgnoringSafeArea(.all)
                        .environmentObject(coordinator)
                        .environment(\.layoutDirection, coordinator.layoutDirection)
                    }
                    else {
                        NavigationStackBackport.NavigationStack(path: $coordinator.path) {
                            ContentView()
                                .backport.navigationDestination(for: Destination.self) { value in
                                    ViewFactory.viewForDestination(value)
                                }
                                .backport.navigationDestination(for: TermsPrivacyItem.self) { value in
                                    TermsPrivacyView(item: value)
                                }
                            //                                .backport.navigationDestination(for: InsuranceType.self) { value in
                            //                                    CarStartView(item: value)
                            //                                }
                                .backport.navigationDestination(for: ResetPasswordSentItem.self) { value in
                                    ResetPasswordView(item: value)
                                }
                                .backport.navigationDestination(for: CarServiceType.self) { value in
                                    PlaceNinView(item: value)
                                }
                                .backport.navigationDestination(for: BookingDetailsSentItem.self) { value in
                                    BookingDetailsView(item: value)
                                }
                                .backport.navigationDestination(for: CarLocationItem.self) { value in
                                    if value.serviceType == .wash {
                                        BookingView(item: value)
                                    }
                                    else if value.serviceType == .road {
                                        HelpOnRoadView(item: value)
                                    }
                                }
                                .backport.navigationDestination(for: FaqType.self) { value in
                                    ServiceHelpView(item: value)
                                }
                                .backport.navigationDestination(for: BatteryTireSentItem.self) { value in
                                    CheckoutView(item: value)
                                }
                                .backport.navigationDestination(for: [BookingsClientItem].self) { value in
                                    BookingListView(items: value)
                                }
                                .backport.navigationDestination(for: OrderSentItem.self) { value in
                                    OrdersListView(item: value)
                                }
                                .backport.navigationDestination(for: EzhelhaType.self) { value in
                                    if value == EzhelhaType.satha {
                                        SathaView()
                                    }
                                    else {
                                        BatteryTireView(item: value)
                                    }
                                }
                                .backport.navigationDestination(for: MojazResult.self) { value in
                                    MojazDetailsView(item: value)
                                }
                                .backport.navigationDestination(isPresented: $sanarVM.isService) {
                                    SanarKit.ServiceView(isNavigationActive: $sanarVM.isService)
                                }
                                .backport.navigationDestination(isPresented: $sanarVM.isBooking) {
                                    SanarKit.BookingListView(isNavigationActive: $sanarVM.isBooking)
                                }
                                .backport.navigationDestination(isPresented: $sanarVM.isConsult) {
                                    SanarKit.ConsultationView(consultationData: [ "dId": $sanarVM.dId, "aId": $sanarVM.aId])
                                }
                                .backport.navigationDestination(for: PoliciesResult.self) { value in
                                    if value.productID == 1 {
                                        PolicyVehiclesView(item: value)
                                    }
                                    else
                                    if value.productID == 2 {
                                        PolicyMedicalView(item: value)
                                    }
                                }
                                .backport.navigationDestination(for: PolicyDetailsSentItem.self) { value in
                                    PolicyDetailsView(item: value)
                                }
                                .backport.navigationDestination(for: [MojazResult].self) { value in
                                    RequestsListView(items: value)
                                }
                                .preferredColorScheme(.light)
                        }
                        .edgesIgnoringSafeArea(.all)
                        .environmentObject(servicesStatusVM)
                        .environmentObject(sanarVM)
                        .environmentObject(coordinator)
                        .environment(\.layoutDirection, coordinator.layoutDirection)
                        .id(coordinator.rootViewId)
                        //                        .onReceive(.statusCodeNotification) { notification in
                        //                            statusError = (notification.object as! String) + "\n" + statusError
                        //                        }
                    }
                }
                if lottieLoading.show {
                    LottieLoadingView()
                }
            }
            .alert("UpdateVersion".localized, isPresented: $forceVersionVM.showUpdateAlert) {
                Button {
                    forceVersionVM.navigate()
                } label: {
                    Text(verbatim: "Update".localized)
                }
            }
            .onReceive(.sanarConsultNotification) { notification in
                sanarVM.startConsult(notification.userInfo)
            }
            .environmentObject(lottieLoading)
        }
    }
}
