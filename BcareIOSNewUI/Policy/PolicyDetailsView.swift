//
//  PolicyDetailsView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine

struct PolicyDetailsView: View {
    let item:PolicyDetailsSentItem
//    @StateObject var policyDetailsVM = PolicyDetailsVM()
    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.3)
            VStack {
                HStack {
                    BackButton()
                    Spacer()
                    Text(verbatim:"PolicyDetails".localized)
                        .font(Fonts.mediumRegular())
                        .foregroundColor(Color.white)
                        .padding(.horizontal,10)
                        .padding(.bottom,15)
                }
                .padding(.horizontal,10)
                VStack {
//                    if policyDetailsVM.submitGetPolicy || policyDetailsVM.item == nil {
//                        LoadingOnlyView()
//                    }
//                    else {
                        List {
                            PolicyDetailsList(title: "PolicyNumber", desc: item.item.policyNo,backColor: Color.white)
                                .padding(.top,30)
                                .modifier(ListItemMode())
                            if let catClass = item.item.categoryClass {
                                PolicyDetailsList(title: "PolicyType", desc: catClass)
                                    .modifier(ListItemMode())
                            }
                            if let comName = item.item.employeeCompanyName {
                                PolicyDetailsList(title: "CompanyName", desc: comName,backColor: Color.white)
                                    .modifier(ListItemMode())
                            }
//                            PolicyDetailsList(title: "MedicalNetwork", desc: policyDetailsVM.item.companyName,backColor: Color.white)
//                                .modifier(ListItemMode())
                            if let res = item.item.deductiblePercentage {
                                PolicyDetailsList(title: "DeductiblePercentage", desc:res)
                                    .modifier(ListItemMode())
                            }
//                            PolicyDetailsList(title: "MaximumProviders", desc: policyDetailsVM.providersMax,backColor: Color.white)
//                                .modifier(ListItemMode())
//                            PolicyDetailsList(title: "MaximumProvidersWithin", desc: policyDetailsVM.providersMaxWithin)
//                                .modifier(ListItemMode())
//                            PolicyDetailsList(title: "HighestLimit", desc: policyDetailsVM.highestLimit,backColor: Color.white)
//                                .modifier(ListItemMode())
                            PolicyDetailsList(title: "NationalIdentity", desc: item.item.nationalID)
                                .modifier(ListItemMode())
                            PolicyDetailsList(title: "Gender", desc: item.item.gender,backColor: Color.white)
                                .padding(.bottom,30)
                                .modifier(ListItemMode())
                        }
                        .modifier(ListMode())
//                    }
                }
                .padding(.top,30)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .modifier(RoundedBackgroundModifer(color: Color(hex: "#F2F4F6")!)) 
                Spacer()
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden() 
    }
}
