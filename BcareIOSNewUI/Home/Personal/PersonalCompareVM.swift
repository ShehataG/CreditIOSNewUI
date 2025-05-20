//
//  PersonalCompareVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine 

@MainActor
final class PersonalCompareVM : MainObservable {
    @Published var income = ""
    @Published var allowance = ""
    @Published var stateMonthly = ""
    @Published var personalMonthly = ""
    @Published var amount = ""

    @Published var incomeErrorText:String?
    @Published var allowanceErrorText:String?
    @Published var stateMonthlyErrorText:String?
    @Published var personalMonthlyErrorText:String?
    @Published var amountErrorText:String?
    @Published var cond1 = false
    @Published var cond1Error = false
    
    @Published var housing = ""
    @Published var housingErrorText:String?
    @Published var showHousingPicker = false
    
    @Published var career = ""
    @Published var careerErrorText:String?
    @Published var showCareerPicker = false
    
    @Published var purpose = ""
    @Published var purposeErrorText:String?
    @Published var showPurposePicker = false
    
    @Published var period = ""
    @Published var periodErrorText:String?
    @Published var showPeriodPicker = false
    
    @Published var salaryType = ""
    @Published var salaryTypeErrorText:String?
    @Published var showSalaryTypePicker = false
    
    @Published var dataDef = [CompareContainerItem]()

    override init() {
        super.init()
        dataDef = [
            CompareContainerItem(image: "",
                                 header: [
                                     CompareItem(title: "FinanceAmount", subTitle: "100,000"),
                                     CompareItem(title: "MonthlyInstallment", subTitle: "250"),
                                     CompareItem(title: "OfferType", subTitle: "InitialOffer".localized)],
                                 top: [
                                    CompareItem(title: "AnnualPercentageRate", subTitle: "4"),
                                    CompareItem(title: "MaximumFinancingLimit", subTitle: "00000"),
                                    CompareItem(title: "FinancingStartDate", subTitle: "2025/1/1"),
                                    CompareItem(title: "FinancingEndDate", subTitle: "2027/1/1"),
                                 ],
                                 bottom: [
                                    CompareItem(title: "AdministrativeFees", subTitle: "00000"),
                                    CompareItem(title: "TypeOfInterestRate", subTitle: "00000"),
                                    CompareItem(title: "ProfitMargin", subTitle: "00000"),
                                    CompareItem(title: "TotalFinancingAmountIncluding", subTitle: "00000"),
           ]),
            CompareContainerItem(image: "",
                                 header: [
                                     CompareItem(title: "FinanceAmount", subTitle: "100,000"),
                                     CompareItem(title: "MonthlyInstallment", subTitle: "250"),
                                     CompareItem(title: "OfferType", subTitle: "InitialOffer".localized)],
                                 top: [
                                    CompareItem(title: "AnnualPercentageRate", subTitle: "4"),
                                    CompareItem(title: "MaximumFinancingLimit", subTitle: "00000"),
                                    CompareItem(title: "FinancingStartDate", subTitle: "2025/1/1"),
                                    CompareItem(title: "FinancingEndDate", subTitle: "2027/1/1"),
                                 ],
                                 bottom: [
                                    CompareItem(title: "AdministrativeFees", subTitle: "00000"),
                                    CompareItem(title: "TypeOfInterestRate", subTitle: "00000"),
                                    CompareItem(title: "ProfitMargin", subTitle: "00000"),
                                    CompareItem(title: "TotalFinancingAmountIncluding", subTitle: "00000"),
           ]),
            CompareContainerItem(image: "",
                                 header: [
                                     CompareItem(title: "FinanceAmount", subTitle: "100,000"),
                                     CompareItem(title: "MonthlyInstallment", subTitle: "250"),
                                     CompareItem(title: "OfferType", subTitle: "InitialOffer".localized)],
                                 top: [
                                    CompareItem(title: "AnnualPercentageRate", subTitle: "4"),
                                    CompareItem(title: "MaximumFinancingLimit", subTitle: "00000"),
                                    CompareItem(title: "FinancingStartDate", subTitle: "2025/1/1"),
                                    CompareItem(title: "FinancingEndDate", subTitle: "2027/1/1"),
                                 ],
                                 bottom: [
                                    CompareItem(title: "AdministrativeFees", subTitle: "00000"),
                                    CompareItem(title: "TypeOfInterestRate", subTitle: "00000"),
                                    CompareItem(title: "ProfitMargin", subTitle: "00000"),
                                    CompareItem(title: "TotalFinancingAmountIncluding", subTitle: "00000"),
           ]),
            CompareContainerItem(image: "",
                                 header: [
                                     CompareItem(title: "FinanceAmount", subTitle: "100,000"),
                                     CompareItem(title: "MonthlyInstallment", subTitle: "250"),
                                     CompareItem(title: "OfferType", subTitle: "InitialOffer".localized)],
                                 top: [
                                    CompareItem(title: "AnnualPercentageRate", subTitle: "4"),
                                    CompareItem(title: "MaximumFinancingLimit", subTitle: "00000"),
                                    CompareItem(title: "FinancingStartDate", subTitle: "2025/1/1"),
                                    CompareItem(title: "FinancingEndDate", subTitle: "2027/1/1"),
                                 ],
                                 bottom: [
                                    CompareItem(title: "AdministrativeFees", subTitle: "00000"),
                                    CompareItem(title: "TypeOfInterestRate", subTitle: "00000"),
                                    CompareItem(title: "ProfitMargin", subTitle: "00000"),
                                    CompareItem(title: "TotalFinancingAmountIncluding", subTitle: "00000"),
           ]),
            CompareContainerItem(image: "",
                                 header: [
                                     CompareItem(title: "FinanceAmount", subTitle: "100,000"),
                                     CompareItem(title: "MonthlyInstallment", subTitle: "250"),
                                     CompareItem(title: "OfferType", subTitle: "InitialOffer".localized)],
                                 top: [
                                    CompareItem(title: "AnnualPercentageRate", subTitle: "4"),
                                    CompareItem(title: "MaximumFinancingLimit", subTitle: "00000"),
                                    CompareItem(title: "FinancingStartDate", subTitle: "2025/1/1"),
                                    CompareItem(title: "FinancingEndDate", subTitle: "2027/1/1"),
                                 ],
                                 bottom: [
                                    CompareItem(title: "AdministrativeFees", subTitle: "00000"),
                                    CompareItem(title: "TypeOfInterestRate", subTitle: "00000"),
                                    CompareItem(title: "ProfitMargin", subTitle: "00000"),
                                    CompareItem(title: "TotalFinancingAmountIncluding", subTitle: "00000"),
           ]),
            
        ]
    }
}
