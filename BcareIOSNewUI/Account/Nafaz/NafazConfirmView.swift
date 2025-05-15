//
//  NafazConfirmView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI
 
struct NafazConfirmView : View {
    @FocusState private var pinFocusState : FocusPin?
    @EnvironmentObject var coordinator: Coordinator
    @State var oTPManager:OTPManager
    @State var showError = false
    @State var showInfo = false
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    let imgWid:CGFloat = isIpad ? 100 : 80
    let number:Int = 45
    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.3)
            ScrollView(showsIndicators: false) {
                BackButton()
                CreditMainLogo()
                VStack(spacing:0) {
                    HeaderView(text: "VerifyNafaz")
                    ZStack {
                        Circle()
                           .stroke(Color(hex:"#9FA2AE")!, lineWidth: 3)
                           .frame(width: imgWid, height: imgWid)
                        ColoredGreenText(text: number.toString())
                            .font(Fonts.tooLargeBold())
                    }
                    .padding(.top,40)
                    ColoredText(text: "VerifyThroughNafaz".localized)
                        .font(Fonts.mediumRegular())
                        .padding(.top,40)
                    ColoredGreenText(text: "OpenNafaz".localized)
                        .font(Fonts.smallRegular())
                        .padding(.top,10)
                    Spacer()
                    RoundedLoaderBu(item: "Next", textColor: .white,backEnableColor: appBlueColor,backDisableColor: appOrangeDarkColor ,width: 0.8, vPadding: 20,disabled: false,showLoader:oTPManager.showConfirmOTPLoader)
                        .padding(.top,60)
                        .onTapGesture {
                        } 
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
            }
            //.scrollIndicators(.never)
        }
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .environment(\.layoutDirection, coordinator.layoutDirection)
        .onReceive(timer) { input in
            if oTPManager.counter > 0 {
                oTPManager.counter -= 1
            }
        }
        .onChange(of: oTPManager.shouldClose, perform: { newValue in
            if newValue {
                oTPManager.showOTP = false
            }
        })
        .onChange(of: oTPManager.showErrorMessage || oTPManager.showInfoMessage, perform: { newValue in
            if newValue {
            }
        })
        .toast(isPresenting: $oTPManager.showErrorMessage){
            AlertToast(displayMode: .hud, type: .error(Color.red), title: oTPManager.errorMessage)
        }
        .toast(isPresenting: $oTPManager.showInfoMessage){
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: oTPManager.infoMessage)
        }
        .onAppear {
            pinFocusState = .pinOne
        }
    }
}
