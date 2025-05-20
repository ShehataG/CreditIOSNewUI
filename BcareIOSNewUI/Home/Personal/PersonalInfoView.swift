//
//  PersonalInfoView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SVGKit


struct PersonalInfoView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var personalInfoVM = PersonalInfoVM()

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                HStack {
                    BackButton(color: Color.black)
                    Spacer()
                }
                VStack(spacing:0) {
                    TopRoundedText(text: "Income")
                    VStack(spacing:0) {
                        TextInputView(placeholder: "TotalIncome", value: $personalInfoVM.income, errorMessage: personalInfoVM.incomeErrorText, type: .income, keyboardType: .numberPad, topPadding: 0)
                        TextInputView(placeholder: "TotalAllowances", value: $personalInfoVM.allowance, errorMessage: personalInfoVM.allowanceErrorText, type: .allowance, keyboardType: .numberPad, topPadding: 10)
                        TextInputView(placeholder: "MonthlyStateCommitment", value: $personalInfoVM.stateMonthly, errorMessage: personalInfoVM.stateMonthlyErrorText, type: .stateMonthly, keyboardType: .numberPad, topPadding: 10)
                        HStack {
                            CheckView(isChecked: $personalInfoVM.cond1,isError: $personalInfoVM.cond1Error)
                            Text(verbatim: "SupportedByState".localized)
                                .font(Fonts.verySmallLight())
                                .foregroundStyle(Color(hex:"#666666")!)
                            Spacer()
                        }
                        .padding(.vertical,15)
                        TextInputView(placeholder: "MonthlyPersonalCommitment", value: $personalInfoVM.personalMonthly, errorMessage: personalInfoVM.personalMonthlyErrorText, type: .personalMonthly, keyboardType: .numberPad, topPadding: 10)
                        TextDropView(placeholder: "HousingType", value: $personalInfoVM.housing, showPicker: $personalInfoVM.showHousingPicker, errorMessage: personalInfoVM.housingErrorText, type: .housing,topPadding: 20)
                        TextDropView(placeholder: "CarrerSector", value: $personalInfoVM.career, showPicker: $personalInfoVM.showCareerPicker, errorMessage: personalInfoVM.careerErrorText, type: .career,topPadding: 20)
                    }
                    .padding(20)
                    .padding(.vertical,10)
                    .modifier(RoundedFullBackgroundModifer(color: Color.lightGray9))
                    TopRoundedText(text: "Finance")
                        .padding(.top,20)
                    VStack(spacing:0) {
                        TextInputView(placeholder: "FinanceAmount", value: $personalInfoVM.amount, errorMessage: personalInfoVM.amountErrorText, type: .amount, keyboardType: .numberPad, topPadding: 10)
                        TextDropView(placeholder: "FinancePurpose", value: $personalInfoVM.purpose, showPicker: $personalInfoVM.showPurposePicker, errorMessage: personalInfoVM.purposeErrorText, type: .purpose,topPadding: 20)
                        TextDropView(placeholder: "FinancePeriod", value: $personalInfoVM.period, showPicker: $personalInfoVM.showPeriodPicker, errorMessage: personalInfoVM.periodErrorText, type: .period,topPadding: 20)
                        TextDropView(placeholder: "SalaryType", value: $personalInfoVM.salaryType, showPicker: $personalInfoVM.showSalaryTypePicker, errorMessage: personalInfoVM.salaryTypeErrorText, type: .salaryType,topPadding: 20)
                    }
                    .padding(20)
                    .padding(.vertical,10)
                    .modifier(RoundedFullBackgroundModifer(color: Color.lightGray9))
                    RoundedColoredText(text:"CheckOffers")
                        .padding(.vertical,40)
                        .onTapGesture {
                            coordinator.push(Destination.personalComparePage)
                        }
                }
            }
        }
        .background(Color.lightGray3)
        .navigationBarBackButtonHidden()
    }
} 
