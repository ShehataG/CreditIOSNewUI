//
//  FontAwesomeExtensions.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import UIKit
import SwiftUI
   
struct FAText: View {
    let text:String
    let color:Color
    let font:Font
    init(text: String,color:Color = Color.white,font:Font = Fonts.fontAwesome()) {
        self.text = text
        self.color = color
        self.font = font
    }
    public var body: some View {
        Text(verbatim: text)
            .font(font)
            .foregroundColor(color)
    }
}

struct FAColoredText: View {
    let text:String
    let color:Color
    let font:Font
    init(text: String,color:Color = Color.white,font:Font = Fonts.fontAwesome()) {
        self.text = text
        self.color = color
        self.font = font
    }
    public var body: some View {
        Text(verbatim: text)
            .font(font)
            .foregroundColor(appBlueColor)
    }
}

struct FA6Text: View {
    let text:String
    let color:Color
    init(text: String,color:Color = Color.white) {
        self.text = text
        self.color = color
    }
    public var body: some View {
        Text(verbatim: text)
            .font(Fonts.fontAwesome6())
            .foregroundColor(color)
    }
}

struct FA6ColoredText: View {
    let text:String
    public var body: some View {
        Text(verbatim: text)
            .font(Fonts.fontAwesome6())
            .foregroundColor(appBlueColor)
    }
}

