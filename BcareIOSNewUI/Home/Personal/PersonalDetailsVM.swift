//
//  PersonalDetailsVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine 

@MainActor
final class PersonalDetailsVM : MainObservable {
    
    @Published var cond1 = false
    @Published var cond1Error = false
    @Published var cond2 = false
    @Published var cond2Error = false
    @Published var item:CompareContainerItem?

    override init() {
        super.init()
         item = CompareContainerItem(image: "",
                             header: [
                                 CompareItem(title: "FinanceAmount", subTitle: "100,000"),
                                 CompareItem(title: "FinancePeriod", subTitle: "9 months"),
                                 CompareItem(title: "FinancingStartDate", subTitle: "2025/1/1"),
                                 CompareItem(title: "FinancingEndDate", subTitle: "2027/1/1")
                             ],
                             top: [
                                CompareItem(title: "AdministrativeFees", subTitle: "00000"),
                                CompareItem(title: "MonthlyInstallment", subTitle: "250"),
                                CompareItem(title: "TypeOfInterestRate", subTitle: "00000"),
                             ],
                             bottom: [
                                CompareItem(title: "FirstInstallment", subTitle: "0"),
                                CompareItem(title: "AnnualProfitMargin", subTitle: "4%"),
       ])
     }
}
