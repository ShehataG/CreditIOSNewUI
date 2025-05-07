//
//  LimitModifer.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine
 
struct LimitModifer: ViewModifier {
    var pin : Binding<String>
    let limit:Int
    init(pin: Binding<String>, limit: Int = 1) {
        self.pin = pin
        self.limit = limit
    }
    func limitText(_ upper : Int) {
        if pin.wrappedValue.count > upper {
            self.pin.wrappedValue = String(pin.wrappedValue.prefix(upper))
        }
        else {
            self.pin.wrappedValue = pin.wrappedValue.replacedArabicDigitsWithEnglish
        }
    }
    func body(content: Content) -> some View {
         content
            .onReceive(Just(pin)) { _  in limitText(limit)}
     }
}

