//
//  PersonalRingVM.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import SwiftUI
import Combine 

@MainActor
final class PersonalRingVM : MainObservable {
    
    @Published var cond1 = false

    override init() {
        super.init()
     }
}
