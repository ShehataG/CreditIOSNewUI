//
//  HelpOnRoadView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct HelpOnRoadView: View {
    let item:CarLocationItem
    @EnvironmentObject var coordinator: Coordinator
    let imgArrowWid:CGFloat = isIpad ? 60.0 : 50.0
    let imgWidth:CGFloat = isIpad ? 30.0 : 15.0
    @StateObject var helpOnRoadVM = HelpOnRoadVM()
    @State var showNext = false
    @State var showRequestDetails = false
    @State var showStatus = true
    @State var showCancel = false
    @State var requestNumber = "U344FDA"
    @State var requestDate = "2025/07/01"
    let imgWid:CGFloat = isIpad ? 40 : 30
    let reasons = (1...4).map { "CancelReason\($0)" }
    let color85 = Color(hex: "#858585")!
    var body: some View {
        if showRequestDetails {
            ZStack(alignment:.top) {
                VStack {
                    VStack(alignment:.leading,spacing:0) {
                        HStack {
                            Spacer()
                            Image(isAr ? "arrowl" : "arrowr")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: imgArrowWid,height: imgArrowWid)
                                .onTapGesture {
                                    showRequestDetails = false
                                }
                        }
                        Text(verbatim: "HelpRoad".localized)
                            .font(Fonts.mediumLight())
                            .foregroundColor(Color.black)
                            .padding(.top,5)
                        Text(verbatim: "Request#".localized + requestNumber)
                            .font(Fonts.largeRegular())
                            .foregroundColor(Color.black)
                            .padding(.top,10)
                        HStack {
                            Spacer()
                            Text(verbatim: "CancelRequest".localized)
                                .font(Fonts.mediumRegular())
                                .foregroundColor(Color.red)
                                .onTapGesture {
                                    showCancel = true
                                 }
                        }
                        .padding(.top,5)
                        .padding(.bottom,20)
                    }
                    .padding(.horizontal,20)
                    .padding(.top,50)
                    .modifier(RoundedBackgroundModifer(color: .white))
                    .edgesIgnoringSafeArea(.top)
                    .padding(.trailing,5)
                    if showStatus {
                        sharedHeader("ProcessingRequest")
                        VStack(spacing: 0) {
                            let sDes = "RequestReceived".localized + "\n" + "RequestNumber#".localized + requestNumber
                            RequestProgressView(title: "RequestSent", subTitle: requestDate, action: nil, isChecked: true, hasLine: true)
                            RequestProgressView(title: "ServiceProvider", subTitle: sDes, action: "ConfirmationDone", isChecked: false,hasLine: true)
                            RequestProgressView(title: "ServiceProviderVisit", subTitle: "WillReach".localized, action: "CreateInitialRequest", isChecked: false,hasLine: false)
                        }
                        .padding(.top,5)
                        .padding(.horizontal,20)
                    }
                    else {
                        sharedHeader("RequestDetails")
                        locDetails()
                            .padding(.top,5)
                            .padding(.horizontal,20)
                    }
                    Spacer()
                    HStack {
                        RequestBottomBu(title: "RequestStatus", image: "requeststatus", isSelected: showStatus)
                            .onTapGesture {
                                showStatus = true
                            }
                        RequestBottomBu(title: "RequestDetails", image: "requestdetails", isSelected: !showStatus)
                            .onTapGesture {
                                showStatus = false
                            }
                    }
                    .padding(.horizontal,20)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,40)
                    .padding(.bottom,50)
                    .modifier(RoundedBackgroundModifer(color: appBlueColor))
                }
                if showCancel {
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
                                        showCancel = false
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
                            VStack(spacing: 0) {
                                ForEach(reasons.indices,id: \.self) { row in
                                    RequestCancelList(title:reasons[row], isChecked: helpOnRoadVM.selectedCancelIndex == row, hasLine: row != reasons.count - 1)
                                        .onTapGesture {
                                            helpOnRoadVM.selectedCancelIndex = row
                                        }
                                }
                                if helpOnRoadVM.selectedCancelIndex == reasons.count - 1 {
                                    TextInputView(placeholder: "CancelReason", value: $helpOnRoadVM.cancel, errorMessage: helpOnRoadVM.cancelErrorText, type: .email, keyboardType: .default, topPadding: 20)
                                }
                            }
                            .padding(.horizontal,30)
                            .padding(.top,20)
                            let color = (helpOnRoadVM.selectedCancelIndex == 3 && helpOnRoadVM.cancel.count <= 10) ? Color.lightGray : Color(hex:"#DC3811")!
                            RoundedLoaderBu(item: "CancelRequest", textColor: .white, backEnableColor: color,backDisableColor:appOrangeDarkColor , width: 0.85,vPadding: 20,showLoader:helpOnRoadVM.submitLoadingCancel)
                                .padding(.top,20)
                                .onTapGesture {
                                    helpOnRoadVM.cancelRequest()
                                 }
                            ColoredText(text:"Back".localized)
                               .font(Fonts.smallSemiBold())
                                .padding(.top,10)
                                .onTapGesture {
                                    showCancel = false
                                }
                            Spacer()
                        }
                        .padding(20)
                        .frame(maxHeight: .infinity)
                        .modifier(RoundedBackgroundModifer(color: .white))
                        .padding(.top,screenHeight * 0.3)
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color(hex:"#E5E5E5")!)
            .navigationBarBackButtonHidden()
        }
        else {
            ZStack {
                VStack {
                    HStack {
                        Text(verbatim: "HelpRoad".localized)
                            .font(Fonts.mediumBold())
                            .foregroundColor(Color.black)
                        Spacer()
                        Image(isAr ? "backwl" : "backwr")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imgArrowWid,height: imgArrowWid)
                            .onTapGesture {
                                coordinator.pop()
                            }
                    }
                    HStack {
                        HStack {
                            Image("carb")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: imgWidth,height: imgWidth)
                            Text(verbatim: "VehiclesM".localized)
                                .font(Fonts.verySmallRegular())
                                .foregroundColor(.black)
                                .padding(.horizontal,5)
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal,20)
                        .background(Rectangle().fill(Color.white).cornerRadius(10.0).shadow(radius: 3,x: -3,y: 3))
                        Spacer()
                    }
                    .padding(.top,20)
                    HStack {
                        ColoredText(text: "CarBreakDown".localized)
                            .font(Fonts.mediumMedium())
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top,20)
                        Spacer()
                    }
                    HStack {
                        Text(verbatim: "VehiclesNotDesired".localized)
                            .font(Fonts.mediumLight())
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top,20)
                        Spacer()
                    }
                    HStack {
                        VStack(spacing: 10) {
                            Text(verbatim: item.car.maker)
                                .font(Fonts.mediumRegular())
                                .foregroundColor(.black)
                            if let sequenceNumber = item.car.sequenceNumber {
                                Text(verbatim: sequenceNumber)
                                    .font(Fonts.smallBold())
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal,5)
                        Spacer()
                        HStack {
                            Text(verbatim: helpOnRoadVM.remainingRequests.toString())
                                .font(Fonts.smallRegular())
                                .foregroundColor(.white)
                                .padding(10)
                                .background(appBlueColor)
                                .clipShape(Circle())
                            Text(verbatim: "RemainingRequests".localized)
                                .font(Fonts.mediumLight())
                                .foregroundColor(Color(hex: "#7A7575")!)
                        }
                        .padding(.horizontal,5)
                        .background(Color.white)
                        .cornerRadius(10.0)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    .background(Rectangle().fill(Color.white).cornerRadius(10.0).shadow(radius: 3,x: -3,y: 3))
                    .padding(.top,20)
                    Spacer()
                    RoundedBu(item: "Next", textColor: Color.white, backColor: appBlueColor,font: Fonts.smallRegular(), width: 0.8, vPadding: 20)
                        .onTapGesture {
                            showNext = true
                        }
                }
                .padding(20)
                .background(Color.white)
                if showNext {
                    ZStack {
                        PlaceholderView()
                        VStack {
                            locDetails()
                            Spacer()
                            RoundedLoaderBu(item: "RequestService", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor , width: 0.8,vPadding: 20,showLoader:helpOnRoadVM.submitLoadingRequest)
                                .padding(.top,20)
                                .onTapGesture {
                                    showRequestDetails = true
                                }
                            ColoredText(text: "Cancel".localized)
                                .font(Fonts.smallSemiBold())
                                .onTapGesture {
                                    showNext = false
                                }
                                .padding(.top,10)
                                .padding(.bottom,40)
                        }
                        .modifier(RoundedBackgroundModifer(color: .white))
                        .edgesIgnoringSafeArea(.bottom)
                        .padding(.top,screenHeight * 0.3)
                    }
                }
            }
            .background(Color(hex:"#E5E5E5")!)
            .navigationBarBackButtonHidden()
        }
    } 
    func sharedHeader(_ text:String) -> some View {
        VStack {
            HStack {
                Text(verbatim: text.localized)
                    .font(Fonts.mediumRegular())
                    .foregroundColor(Color.black)
                Spacer()
            }
            VStack {
            }
            .frame(width: screenWidth * 0.85, height: 1)
            .background(Color(hex:"#C4C4C4")!)
            .padding(.top,10)
        }
        .padding(.horizontal,20)
    }
    func locDetails() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading,spacing: 10) {
                    Text(verbatim: item.car.maker)
                        .font(Fonts.mediumRegular())
                        .foregroundColor(.black)
                    if let sequenceNumber = item.car.sequenceNumber {
                        Text(verbatim: sequenceNumber)
                            .font(Fonts.mediumRegular())
                            .foregroundColor(color85)
                    }
                }
                .frame(maxWidth: .infinity)
                Spacer()
                VStack(alignment: .leading,spacing: 10) {
                    Text(verbatim: "Service".localized)
                        .font(Fonts.verySmallMedium())
                        .foregroundColor(.black)
                    Text(verbatim: helpOnRoadVM.serviceType)
                        .font(Fonts.smallMedium())
                        .foregroundColor(color85)
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(10.0)
            }
            .padding(20)
            HStack {
                Image("helppin")
                    .resizable()
                    .frame(width: imgWid,height: imgWid)
                VStack(alignment: .leading,spacing: 10) {
                    Text(verbatim: "SelectedLocation".localized)
                        .font(Fonts.mediumRegular())
                        .foregroundColor(.black)
                    Text(verbatim: item.location)
                        .font(Fonts.mediumRegular())
                        .foregroundColor(color85)
                }
                .padding(.horizontal,10)
                Spacer()
            }
            .padding(.horizontal,20)
            .padding(.vertical,10)
            .background(Rectangle().fill(Color(hex:"#E5E7EC")!).cornerRadius(10.0).shadow(radius: 3,x: -3,y: 3))
            .padding(.horizontal,20)
            .padding(.top,40)
        }
    }
}
