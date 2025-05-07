//
//  BookingVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

@MainActor final class ServiceHelpValues {
    static func getFAQ(_ type:FaqType)-> ServiceHelpItem {
        if type == FaqType.wash {
            return ServiceHelpItem(
                service: "CarWashNoSpacer".localized,
                questions: (1...6).map { ServiceQuestionItem(question: "CarWashFAQTitle\($0)".localized, answer: "CarWashFAQAnswer\($0)".localized)}
            )
        }
        else {
            return ServiceHelpItem(
                service: "CarWashNoSpacer".localized,
                questions: (1...6).map { ServiceQuestionItem(question: "CarWashFAQTitle\($0)".localized, answer: "CarWashFAQAnswer\($0)".localized)}
            )
        }
    }
}
