//
//  ProfileView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine


struct ProfileView: View {
    @EnvironmentObject var coordinator: Coordinator
    let imgWid:CGFloat = isIpad ? 70.0 : 50.0
    @StateObject var profileVM = ProfileVM()
//    @StateObject var homeVM = HomeVM()
    @State var showPolicyPicker = false

    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.5)
            ScrollView(showsIndicators: false) {
                HStack  {
                    Text(verbatim:"MyAccount".localized)
                        .font(Fonts.mediumRegular())
                        .foregroundColor(Color.white)
                    Spacer()
                    FA6Text(text: FontAwesome6.syncIcon,color: profileVM.canUpdatReflect ? Color.white : Color.lightGray)
                        .onTapGesture {
                            if profileVM.canUpdatReflect {
                                profileVM.getInfo()
                            }
                        }
                }
                .padding(.horizontal,20)
                .padding(.bottom,20)
                VStack {
                    if profileVM.submitLoading {
                        LoadingView()
                            .frame(height: screenHeight * 0.5)
                    }
                    else {
                        Image(profileVM.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imgWid,height: imgWid)
                        Text(verbatim:profileVM.name)
                            .font(Fonts.largeRegular())
                            .foregroundColor(Color.black)
                            .padding(.top,5)
                        GrayText(text:profileVM.phone)
                            .font(Fonts.smallRegular())
                            .padding(.top,1)
                        HStack(alignment: .top) {
                            ProfileCountView(text: "Policies", count: profileVM.policiesCount)
                                .onTapGesture {
                                    if profileVM.policiesCount > 0 {
                                        coordinator.push(Destination.allPoliciesPage)
                                    }
                                }
//                            if profileVM.policiesCount > 0 {
//                                HStack {
//                                    Text(verbatim:profileVM.currentPolicy)
//                                        .font(Fonts.verySmallRegular())
//                                        .foregroundColor(Color.black)
//                                        .padding(.horizontal,10)
//                                    Spacer()
//                                    if profileVM.policiesCount > 1 {
//                                        Text(verbatim: FontAwesome.arrowDownIcon)
//                                            .font(Fonts.fontAwesome15_20())
//                                            .foregroundColor(Color(hex: "#001A72")!)
//                                    }
//                                }
//                                .onTapGesture {
//                                    showPolicyPicker = true
//                                 }
//                            }
//                            ProfileCountView(text: "MedicalAgreements", count: profileVM.medicalAgreementsCount)
                            Spacer()
                        }
                        .padding(.top,5)
                        VStack {
                            HStack {
                                Text(verbatim:"ContactDetails".localized)
                                    .font(Fonts.mediumRegular())
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal,10)
                                Spacer()
                            }
                            .padding(.vertical,10)
                            VStack(spacing:15) {
                                ProfileContactsView(profileVM:profileVM,top: "PhoneNumber", placeholder: "PhoneNumberX",disable: profileVM.disablePhone, value: $profileVM.phoneEdited, isEditing: $profileVM.isEditingPhone, type: .phone, keyboardType: .numberPad)
                                ProfileContactsView(profileVM:profileVM,top: "EmailAddress", placeholder: "EmailAddress",disable: profileVM.disableEmail, value: $profileVM.emailEdited, isEditing: $profileVM.isEditingEmail, type: .email, keyboardType: .emailAddress)
                            }
                            .padding(.horizontal,10)
                        }
                        //                    VStack {
                        //                        HStack {
                        //                            Text(verbatim:"Followers".localized)
                        //                                .font(Fonts.mediumRegular())
                        //                                .foregroundColor(Color.black)
                        //                                .padding(.horizontal,10)
                        //                            Spacer()
                        //                        }
                        //                        .padding(.vertical,10)
                        //                        VStack(spacing:15) {
                        //                            ProfileFollowersView(top: "FollowersManagment", bottom: 0)
                        //                            ProfileFollowersView(top: "ChangeFollowerNumber", bottom: 0)
                        //                        }
                        //                        .padding(.horizontal,10)
                        //                    }
                        RoundedLoaderBu(item: "Logout", textColor: .white, backEnableColor: Color(hex:"#DC3811")!,backDisableColor:appOrangeDarkColor , width: 0.0,vPadding: 10,showLoader:profileVM.submitLoadingLogout)
                            .padding(.top,100)
                            .onTapGesture {
                                profileVM.showLogoutAlert = true
                            }
                        Text(verbatim:profileVM.appVersion)
                            .font(Fonts.smallLight())
                            .foregroundColor(Color.lightGray)
                            .padding(.top,5)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
            }
            //.scrollIndicators(.never) 
        }
        .toast(isPresenting: $profileVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: profileVM.toastContent)
        }
        .onChange(of: profileVM.makeLogout, perform: { _ in
            coordinator.reset()
        })
        .onChange(of: profileVM.isEditingEmail, perform: { newValue in
            if newValue {
                profileVM.isEditingPhone = false
            }
        })
        .onChange(of: profileVM.isEditingPhone, perform: { newValue in
            if newValue {
                profileVM.isEditingEmail = false
            }
        }) 
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $profileVM.showOTP,onDismiss: {
        }) {
            OtpView(oTPManager: profileVM)
                .modifier(PresentationBackgroundModifier())
        }
        .fullScreenCover(isPresented: $showPolicyPicker,onDismiss: {
            showPolicyPicker = false
        }) {
            VehiclePrintPicker(vehicles: policiesG.map {$0.model() ?? ""}, selected: $profileVM.currentPolicy, selecVehicle: $profileVM.current)
                .modifier(PresentationBackgroundModifier())
        }
        .onChange(of: profileVM.shouldClose, perform: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                coordinator.goToRoot()
            }
        })
        .onReceive(.policyCountNotification) { _ in
            DispatchQueue.main.async {
                profileVM.updateCount()
            }
        }
        .actionSheet(isPresented: $profileVM.showLogoutAlert) {
            ActionSheet(
                title: Text(verbatim: "Confirm".localized),
                message: Text(verbatim: "LogoutSure".localized),
                buttons: [
                    .destructive(Text(verbatim: "Logout".localized)) {
                        profileVM.logout()
                    },
                    .default(Text(verbatim: "Cancel".localized)) {
                    }
                ]
            )
        }
    }
}
