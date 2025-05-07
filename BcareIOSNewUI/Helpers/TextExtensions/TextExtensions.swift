//
//  TextExtensions.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

struct ColoredText: View {
    let text:String
    public var body: some View {
        Text(verbatim: text)
            .foregroundColor(appBlueColor)
    }
}
 
struct GrayText: View {
    let text:String
    public var body: some View {
        Text(verbatim: text)
            .foregroundColor(Color.lightGray)
    }
}
 
