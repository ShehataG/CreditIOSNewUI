//
//  ColorExtensions.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI

let appBlueColor = Color(hex:"#4F3366")!
let appGreenColor = Color(hex:"#00B46D")!
let appOrangeColor = Color(hex:"#FAA62D")!
let appOrangeDarkColor = Color(hex:"#A4753A")!

extension Color {
    static let lightGray = Color(hex:"#9295A3")!
    static let lightGrayMid = Color(hex:"#D9D9D9")!
    static let lightGrayMore = Color(hex:"#F2F2F2")!
    static let lightGrayCommon = Color(hex:"#F9F9F9")!
    static let sevenLightGray = Color(hex:"#707070")!
    
    static let lightGray3 = Color(hex:"#F3F3F3")!
    static let lightGray9 = Color(hex:"#F9F9F9")!
    
       /**
     Color from  hex string
     
     - Parameter hex: #rrggbbaa hex color (red, green, blue, alpha)
     - Parameter alpha: optional opacity; overrides any hex opacity  present
     - Returns: closest Color match or nil if unrecognizable
     
     The hex string may contain css style shorthand notation as illustrated in the examples.
     ```
     // Example use:
     let color1 = Color(rgb: "#80") // -> #808080ff
     let color2 = Color(rgb: "#abc") // -> #aabbccff
     let color3 = Color(rgb: "abc8") // -> #aabbcc88
     let color4 = Color(rgb: "ffff00") // -> #ffff00ff
     let color5 = Color(rgb: "#808080ff") // #rrggbbaa
     let color6 = Color(rgb: "#12", alpha: 0.5) // -> #12121280
     ```
     */
    init?(hex: String, alpha: Double? = nil) {
        var hexDigits = hex.first == "#" ? String(hex.dropFirst()) : hex
        for digit in hexDigits {
            guard "0123456789abcdefABCDEF".contains(digit) else { return nil }
        }
        if hexDigits.count == 2 { // grayscale
            hexDigits += hexDigits + hexDigits
        }
        if hexDigits.count <= 4 { // #rgb or #rgba
            hexDigits = hexDigits.map { "\($0)\($0)" } .joined(separator: "")
        }
        if hexDigits.count == 6 { // #rrggbb
            hexDigits += "ff"
        }
        // #rrggbbaa
        guard hexDigits.count == 8 else { return nil }
        let digits = Array(hexDigits)
        let rgba = stride(from: 0, to: 8, by: 2).map {
            Double(Int("\(digits[$0])\(digits[$0 + 1])", radix: 16)!) / 255.0
        }
        self = Color(.sRGB, red: rgba[0], green: rgba[1], blue: rgba[2], opacity: alpha ?? rgba[3])
    }
}
