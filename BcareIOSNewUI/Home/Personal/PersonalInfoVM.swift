//
//  LoginVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import LocalAuthentication
import KeychainSwift
import AdjustSdk

@MainActor
final class PersonalInfoVM : MainObservable {
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
    
    override init() {
        super.init()
    }
}
