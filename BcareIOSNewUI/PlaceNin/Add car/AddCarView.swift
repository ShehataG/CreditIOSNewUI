//
//  AddCarView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
import MapKit
 
struct AddCarView : View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var addCarVM = AddCarVM()
    @State var showVin = true
    @State var showVinDetails = false
    @State var showMakerSearch = false
    @State var showModelSearch = false
    @State var showModelSearchFull = false
    @State var showYear = false
    let imgWid:CGFloat = isIpad ? 25 : 15
    let imgArrowWid:CGFloat = isIpad ? 60.0 : 50.0
    @FocusState private var platNumberIsFocused: Bool
    @FocusState private var vinsFocused: Bool

    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.3)
            VStack {
                HeaderWithBackKeyboardView(text: "AddNewCar",showKeyboard: platNumberIsFocused || vinsFocused) {
                    platNumberIsFocused = false
                    vinsFocused = false
                }
                 VStack(spacing:0) {
                    VStack(spacing:0) {
                        HStack {
                            ManualVinBu(title: "Vin", textColor: Color.white , isSelected: showVin)
                                .onTapGesture {
                                    showVin = true
                                }
                            ManualVinBu(title: "Manual", textColor: appBlueColor, isSelected: !showVin)
                                .onTapGesture {
                                    showVin = false
                                }
                        }
                        .padding(.horizontal,20)
                        .padding(.vertical,10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.top,10)
                        HStack {
                            Text(verbatim: "EnterCarDetails".localized)
                                .font(Fonts.verySmallRegular())
                                .foregroundColor(.black)
                                .padding(.vertical,10)
                            Spacer()
                        }
                        .padding(.top,10)
                        if showVin {
                            TextInputView(placeholder: "Vin", value: $addCarVM.vin, errorMessage: addCarVM.vinErrorText, type: .vin, keyboardType: .numberPad, topPadding: 10)
                                .modifier(LimitModifer(pin: $addCarVM.vin, limit: 10))
                                .focused($vinsFocused)
                            HStack {
                                Image("carinfo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: imgWid,height: imgWid)
                                Text(verbatim: "WhereVin".localized)
                                    .font(Fonts.verySmallRegular())
                                    .foregroundColor(.black)
                                    .onTapGesture {
                                        showVinDetails = true
                                    }
                                Spacer()
                            }
                            .padding(.top,10)
                            VStack {
                                Spacer()
                                RoundedLoaderBu(item: "DownloadCarDetails", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor , width: 0.8,vPadding: 20,showLoader:addCarVM.submitLoadingDownload)
                                    .onTapGesture {
                                        addCarVM.addCarWithVin()
                                     }
                                ColoredText(text:"Cancel".localized)
                                    .font(Fonts.verySmallSemiBold())
                                    .padding(.top,5)
                                    .onTapGesture {
                                        coordinator.pop()
                                    }
                            }
                        }
                        else {
                            CarModelnputView(placeholder: "VehicleMaker", value: $addCarVM.maker, showModelPicker: $showMakerSearch,errorMessage: addCarVM.makerErrorText, type: .carMaker, topPadding: 10)
                            CarModelnputView(placeholder: "VehicleModel", value: $addCarVM.model, showModelPicker: $showModelSearch,errorMessage: addCarVM.modelErrorText, type: .carModel, topPadding: 10)
                            CarModelnputView(placeholder: "VehicleYear", value: $addCarVM.year, showModelPicker: $showYear, errorMessage: addCarVM.yearErrorText, type: .carYear, topPadding: 10)
                            HStack(alignment:.top) {
                                TextInputView(placeholder: "PlateNumber", value: $addCarVM.plateNumber, errorMessage: addCarVM.plateNumberErrorText, type: .plateNumber, keyboardType: .numberPad, topPadding: 10)
                                    .modifier(LimitModifer(pin: $addCarVM.plateNumber, limit: 4))
                                    .focused($platNumberIsFocused)
                                TextInputView(placeholder: "PlateLetters", value: $addCarVM.plateLetters, errorMessage: addCarVM.plateLettersErrorText, type: .plateLetters, keyboardType: .alphabet, topPadding: 10)
                                    .modifier(LimitModifer(pin: $addCarVM.plateLetters, limit: 3))
                            }
                            VStack {
                                Spacer()
                                RoundedLoaderBu(item: "SaveCarDetails", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor , width: 0.8,vPadding: 20,showLoader:addCarVM.submitLoadingSave)
                                    .onTapGesture {
                                        addCarVM.addCarManual()
                                    }
                                ColoredText(text:"Cancel".localized)
                                    .font(Fonts.verySmallSemiBold())
                                    .padding(.top,5)
                                    .onTapGesture {
                                        coordinator.pop()
                                    }
                            }
                        }
                    }
                    .padding(.horizontal,20)
                }
                .padding(.vertical,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
            }
        }
        .onChange(of: addCarVM.plateNumber, perform: { newValue in
            if newValue.count == 4 {
                platNumberIsFocused = false
            }
        })
        .onChange(of: addCarVM.vin, perform: { newValue in
            if newValue.count == 10 {
                vinsFocused = false
            }
        })
        .onChange(of: addCarVM.goBack, perform: { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                coordinator.pop()
            }
        })
        .onChange(of: showModelSearch, perform: { newValue in
            showModelSearchFull = showModelSearch && addCarVM.currentMaker != nil
        })
        .fullScreenCover(isPresented: $showMakerSearch,onDismiss: {
            showMakerSearch = false
         }) {
             let data = addCarVM.currentMotorVehicles
             let filtered = addCarVM.searchMaker == "" ? data : data.filter { $0.makerNameAr.contains(addCarVM.searchMaker) || $0.makerNameEn.contains(addCarVM.searchMaker) }
             let result = filtered.map { $0.name }
             AddCarSearchView(search: $addCarVM.searchMaker, filtered: result,
                 closeClicked: {
                     showMakerSearch = false
                     addCarVM.searchMaker = ""
                 },
                 selectedClicked: { row in
                     let item = filtered[row]
                     showModelSearch = false
                     addCarVM.currentMaker = item
                     addCarVM.maker = item.name
                     showMakerSearch = false
                     addCarVM.searchMaker = ""
             })
               .modifier(PresentationBackgroundModifier())
        }
        .fullScreenCover(isPresented: $showModelSearchFull,onDismiss: {
             showModelSearchFull = false
          }) {
              let data = addCarVM.currentMaker!.models
              let filtered = addCarVM.searchModel == "" ? data : data.filter { $0.modelNameAr.contains(addCarVM.searchModel) || $0.modelNameEn.contains(addCarVM.searchModel) }
              let result = filtered.map { $0.name }
              AddCarSearchView(search: $addCarVM.searchModel, filtered: result,
                  closeClicked: {
                      showModelSearch = false
                      addCarVM.searchModel = ""
                  },
                  selectedClicked: { row in
                      let item = filtered[row]
                      addCarVM.currentModel = item
                      addCarVM.model = item.name
                      showModelSearch = false
                      addCarVM.searchModel = ""
              })
                .modifier(PresentationBackgroundModifier())
        }
        .fullScreenCover(isPresented: $showVinDetails,onDismiss: {
            showVinDetails = false
        }) {
            VinDetailsView()
                .modifier(PresentationBackgroundModifier())
        }
        .fullScreenCover(isPresented: $showYear,onDismiss: {
            showYear = false
         }) {
            YearPicker(title:"ModelYear".localized,isHigri:false,sentYear:$addCarVM.year,fromNow: true)
                .modifier(PresentationBackgroundModifier())
        }
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .toast(isPresenting: $addCarVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: addCarVM.toastContent)
        }
        .toast(isPresenting: $addCarVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: addCarVM.toastContentInfo)
        }
    }
}
