//
//  CancelBookingView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine

struct CancelBookingView: View {
//    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coordinator: Coordinator
    @State var cancelManager:CancelBookingProtocol
    @State var selected = 0
    let imgArrowWid:CGFloat = isIpad ? 60.0 : 50.0
    @StateObject var cancelBookingVM = CancelBookingVM()
    let otherColor = Color(hex:"#DC3811")!
    var body: some View {
        ZStack {
            PlaceholderView()
            VStack {
                HStack  {
                    Spacer()
                    Image("closebacked")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imgArrowWid,height: imgArrowWid)
                        .onTapGesture {
                            cancelManager.showCancel = false
                        }
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text(verbatim: "AboutCancelRequest".localized)
                            .font(Fonts.smallBold())
                            .foregroundColor(.black)
                            .modifier(MultiLine(alignment: .leading))
                        Text(verbatim: "CancelReasonHelp".localized)
                            .font(Fonts.smallLight())
                            .foregroundColor(Color.sevenLightGray)
                            .modifier(MultiLine(alignment: .leading))
                            .padding(.top,5)
                    }
                    Spacer()
                }
                let reasons = cancelBookingVM.reasons
                VStack(spacing: 0) {
                    ForEach(reasons.indices,id: \.self) { row in
                        RequestCancelList(title:reasons[row], isChecked: cancelBookingVM.selectedCancelIndex == row, hasLine: row != reasons.count - 1)
                            .onTapGesture {
                                cancelBookingVM.selectedCancelIndex = row
                            }
                    }
                    if cancelBookingVM.selectedCancelIndex == reasons.count - 1 {
                        TextInputView(placeholder: "CancelReason", value: $cancelBookingVM.cancel, errorMessage: cancelBookingVM.cancelErrorText, type: .email, keyboardType: .default, topPadding: 20)
                    }
                }
                .padding(.horizontal,30)
                .padding(.top,20)
                let color = cancelManager.submitLoadingCancel ? otherColor : ((cancelBookingVM.selectedCancelIndex == 3 && cancelBookingVM.cancel.count <= 10) ? Color.lightGray : appBlueColor)
                RoundedLoaderBu(item: "CancelRequest", textColor: .white, backEnableColor: color,backDisableColor:appOrangeDarkColor , width: 0.85,vPadding: 20,showLoader:cancelManager.submitLoadingCancel)
                    .padding(.top,20)
                    .onTapGesture {
                        cancelBookingVM.proceedCancel(cancelManager)
                    }
                ColoredText(text:"Back".localized)
                    .font(Fonts.smallSemiBold())
                    .padding(.top,10)
                    .onTapGesture {
                        cancelManager.showCancel = false
                    }
                Spacer()
            }
            .padding(20)
            .frame(maxHeight: .infinity)
            .modifier(RoundedBackgroundModifer(color: .white))
            .padding(.top,screenHeight * 0.3)
        }
        .environment(\.layoutDirection, coordinator.layoutDirection)
        .edgesIgnoringSafeArea(.bottom)
    }
}
