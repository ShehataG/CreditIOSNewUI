//
//  OtpView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

@MainActor var counterBase = 90

enum FocusPin {
    case pinOne, pinTwo, pinThree, pinFour
}
struct OtpView : View {
    @FocusState private var pinFocusState : FocusPin?
    @EnvironmentObject var coordinator: Coordinator
    @State var oTPManager:OTPManager
    @State var field1 = ""
    @State var field2 = ""
    @State var field3 = ""
    @State var field4 = ""
    @State var field1Error = false
    @State var field2Error = false
    @State var field3Error = false
    @State var field4Error = false
    @State var showError = false
    @State var showInfo = false
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.3)
            ScrollView(showsIndicators: false) {
                BackButton()
                HeaderView(text: "Verification")
                VStack(spacing:0) {
                    Text(verbatim:"MessageSent".localized + " " + oTPManager.phone.addAsterisks)
                        .font(Fonts.mediumRegular())
                        .foregroundColor(appBlueColor)
                        .padding(.top,60)
                        .padding(.bottom,40)
                        .padding(.horizontal,10)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    HStack {
                        TextField("", text: $field1)
                          .modifier(OtpModifer(pin:$field1, showError: field1Error))
                           .onChange(of:field1) { newVal in
                               if newVal.count == 1 {
                                   field1Error = false
                                   pinFocusState = .pinTwo
                               }
                               else {
                                   field1Error = true
                               }
                           }
                           .focused($pinFocusState, equals: .pinOne)
                        
                        TextField("", text: $field2)
                         .modifier(OtpModifer(pin:$field2, showError: field2Error))
                           .onChange(of:field2) { newVal in
                               if newVal.count == 1 {
                                   field2Error = false
                                   pinFocusState = .pinThree
                               }
                               else {
                                   field2Error = true
                                   pinFocusState = .pinOne
                               }
                           }
                           .focused($pinFocusState, equals: .pinTwo)
                        
                        TextField("", text: $field3)
                            .modifier(OtpModifer(pin:$field3, showError: field3Error))
                           .onChange(of:field3) { newVal in
                               if newVal.count == 1 {
                                   field3Error = false
                                   pinFocusState = .pinFour
                               }
                               else {
                                   field3Error = true
                                   pinFocusState = .pinTwo
                               }
                           }
                           .focused($pinFocusState, equals: .pinThree)
                        
                        TextField("", text: $field4)
                            .modifier(OtpModifer(pin:$field4, showError: field4Error))
                            .onChange(of:field4) { newVal in
                                if newVal.count != 1 {
                                    field4Error = true
                                    pinFocusState = .pinThree
                                    return
                                }
                                field4Error = false
                                let value = field1 + field2 + field3 + field4
                                if value.count == 4 && !oTPManager.showConfirmOTPLoader {
                                   oTPManager.verify(value)
                                }
                            }
                           .focused($pinFocusState, equals: .pinFour)
                    }
                    .environment(\.layoutDirection, .leftToRight)
                    .padding(.vertical,20)
                    .frame(width: screenWidth * 0.8)
                    .disabled(oTPManager.showConfirmOTPLoader)
                    let value = field1 + field2 + field3 + field4
                    RoundedLoaderBu(item: "Verify", textColor: .white,backEnableColor: appBlueColor,backDisableColor: appOrangeDarkColor ,width: 0.8, vPadding: 20,disabled: value.count != 4,showLoader:oTPManager.showConfirmOTPLoader)
                        .padding(.top,20)
                        .onTapGesture {
                            if !oTPManager.showConfirmOTPLoader {
                                field1Error = field1.isEmpty
                                field2Error = field2.isEmpty
                                field3Error = field3.isEmpty
                                field4Error = field4.isEmpty
                                if value.count == 4 {
                                    oTPManager.verify(value)
                                }
                            }
                        }
                    if oTPManager.counter > 0 {
                        HStack(spacing:2) {
                            Text(verbatim:"ResendCode".localized)
                                .font(Fonts.tooSmallLight())
                                .foregroundColor(Color.black)
                            Text(verbatim:oTPManager.counter.toString())
                                .font(Fonts.tooSmallLight())
                                .foregroundColor(appOrangeColor)
                            Text(verbatim:"Seconds".localized)
                                .font(Fonts.tooSmallLight())
                                .foregroundColor(Color.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top,20)
                    }
                    let color = oTPManager.counter > 0 ? Color.black : appBlueColor
                    HStack(spacing:3) {
                        Spacer()
                        Text(verbatim:"DidntReceiveCode".localized)
                            .font(Fonts.tooSmallLight())
                            .foregroundColor(Color.black)
                        Text(verbatim:"Resend".localized)
                            .font(Fonts.tooSmallLight())
                            .foregroundColor(color)
                            .disabled(oTPManager.counter > 0)
                            .onTapGesture {
                                if oTPManager.counter == 0 && !oTPManager.showResendOTPLoader {
                                    oTPManager.resend()
                                }
                            }
                        if oTPManager.showResendOTPLoader {
                            PureProgressView(color: Color.white)
                                .padding(.horizontal,5)
                        }
                        Spacer()
                    }
                    .padding(.top,15)
                }
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
        .onChange(of: field1, perform: { newValue in
           assignValues(newValue)
        })
        .onChange(of: field2, perform: { newValue in
           assignValues(newValue)
        })
        .onChange(of: field3, perform: { newValue in
           assignValues(newValue)
        })
        .onChange(of: field4, perform: { newValue in
           assignValues(newValue)
        })
        .onChange(of: oTPManager.showErrorMessage || oTPManager.showInfoMessage, perform: { newValue in
            if newValue {
                clearValues()
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
    func clearValues() {
        field1 = ""
        field2 = ""
        field3 = ""
        field4 = ""
    }
    func assignValues(_ newValue:String) {
        if newValue.count == 4 {
            let values = newValue.map { String($0) }
            field1 = values.first!
            field2 = values[1]
            field3 = values[2]
            field4 = values.last!
        }
    }
}
