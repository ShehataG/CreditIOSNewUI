//
//  ModifierExtensions.swift
//  MprayerSWUI
//
//  Created by Ahmed Mahmoud on 4/12/23.
//

import Foundation
import SwiftUI
import UIKit

@MainActor
struct Fonts {
  
    static func tooSmallLight() -> Font{
        let size:CGFloat = isIpad ? 13 : 11
        return Font.custom("ReadexPro-Light", size: size)
    }
    
    static func tooSmallRegular() -> Font{
        let size:CGFloat = isIpad ? 13 : 11
        return Font.custom("ReadexPro-Regular", size: size)
    }

    static func tooSmallMedium() -> Font{
        let size:CGFloat = isIpad ? 13 : 11
        return Font.custom("ReadexPro-Medium", size: size)
    }
    
    static func tooSmallBold() -> Font{
        let size:CGFloat = isIpad ? 13 : 11
        return Font.custom("ReadexPro-Bold", size: size)
    }
    
    static func verySmallLight() -> Font{
        let size:CGFloat = isIpad ? 15 : 13
        return Font.custom("ReadexPro-Light", size: size)
    }
    
    static func verySmallRegular() -> Font{
        let size:CGFloat = isIpad ? 15 : 13
        return Font.custom("ReadexPro-Regular", size: size)
    }
    
    static func verySmallMedium() -> Font{
        let size:CGFloat = isIpad ? 15 : 13
        return Font.custom("ReadexPro-Medium", size: size)
    }
    
    static func verySmallSemiBold() -> Font{
        let size:CGFloat = isIpad ? 15 : 13
        return Font.custom("ReadexPro-SemiBold", size: size)
    }
    
    static func verySmallBold() -> Font{
        let size:CGFloat = isIpad ? 15 : 13
        return Font.custom("ReadexPro-Bold", size: size)
    }
    
    static func smallLight() -> Font{
        let size:CGFloat = isIpad ? 17 : 15
        return Font.custom("ReadexPro-Light", size: size)
    }
    
    static func smallRegular() -> Font{
        let size:CGFloat = isIpad ? 17 : 15
        return Font.custom("ReadexPro-Regular", size: size)
    }
    
    static func smallMedium() -> Font{
        let size:CGFloat = isIpad ? 17 : 15
        return Font.custom("ReadexPro-Medium", size: size)
    }
    
    static func smallSemiBold() -> Font{
        let size:CGFloat = isIpad ? 17 : 15
        return Font.custom("ReadexPro-SemiBold", size: size)
    }
    
    static func smallBold() -> Font{
        let size:CGFloat = isIpad ? 17 : 15
        return Font.custom("ReadexPro-Bold", size: size)
    }

    static func mediumLight() -> Font{
        let size:CGFloat = isIpad ? 20 : 17
        return Font.custom("ReadexPro-Light", size: size)
    }

    static func mediumRegular() -> Font{
        let size:CGFloat = isIpad ? 20 : 17
        return Font.custom("ReadexPro-Regular", size: size)
    }
    
    static func mediumMedium() -> Font{
        let size:CGFloat = isIpad ? 20 : 17
        return Font.custom("ReadexPro-Medium", size: size)
    }
    
    static func mediumSemiBold() -> Font{
        let size:CGFloat = isIpad ? 20 : 17
        return Font.custom("ReadexPro-SemiBold", size: size)
    }
    
    static func mediumBold() -> Font{
        let size:CGFloat = isIpad ? 20 : 17
        return Font.custom("ReadexPro-Bold", size: size)
    }

    static func largeLight() -> Font{
        let size:CGFloat = isIpad ? 22 : 19
        return Font.custom("ReadexPro-Light", size: size)
    }
    
    static func largeRegular() -> Font{
        let size:CGFloat = isIpad ? 22 : 19
        return Font.custom("ReadexPro-Regular", size: size)
    }
    
    static func largeMedium() -> Font{
        let size:CGFloat = isIpad ? 22 : 19
        return Font.custom("ReadexPro-Medium", size: size)
    }
    
    static func largeSemiBold() -> Font{
        let size:CGFloat = isIpad ? 22 : 19
        return Font.custom("ReadexPro-SemiBold", size: size)
    }
    
    static func largeBold() -> Font{
        let size:CGFloat = isIpad ? 22 : 19
        return Font.custom("ReadexPro-Bold", size: size)
    }
    
    static func veryLargeLight() -> Font{
        let size:CGFloat = isIpad ? 24 : 21
        return Font.custom("ReadexPro-Light", size: size)
    }
    
    static func veryLargeRegular() -> Font{
        let size:CGFloat = isIpad ? 24 : 21
        return Font.custom("ReadexPro-Regular", size: size)
    }
    
    static func veryLargeMedium() -> Font{
        let size:CGFloat = isIpad ? 24 : 21
        return Font.custom("ReadexPro-Medium", size: size)
    }
    
    static func veryLargeSemiBold() -> Font{
        let size:CGFloat = isIpad ? 24 : 21
        return Font.custom("ReadexPro-SemiBold", size: size)
    }
    
    static func veryLargeBold() -> Font{
        let size:CGFloat = isIpad ? 24 : 21
        return Font.custom("ReadexPro-Bold", size: size)
    }
    
    static func fontAwesome() -> Font{
        let size:CGFloat = isIpad ? 35 : 25
        return Font.custom("FontAwesome", size: size)
    }
    
    static func fontAwesome15_20() -> Font{
        let size:CGFloat = isIpad ? 20 : 15
        return Font.custom("FontAwesome", size: size)
    }
    
    static func fontAwesome30_40() -> Font{
        let size:CGFloat = isIpad ? 40 : 30
        return Font.custom("FontAwesome", size: size)
    }
    
    static func fontAwesome40_50() -> Font{
        let size:CGFloat = isIpad ? 50 : 40
        return Font.custom("FontAwesome", size: size)
    }
    
    static func fontAwesome20_30() -> Font{
        let size:CGFloat = isIpad ? 30 : 20
        return Font.custom("FontAwesome", size: size)
    }
    
    static func fontAwesome(withSize:CGFloat) -> Font{
        return Font.custom("FontAwesome", size: withSize)
    }
    
    static func fontAwesome6() -> Font{
        let size:CGFloat = isIpad ? 35 : 25
        return Font.custom("FontAwesome6Free-Solid", size: size)
    }
    
    static func fontAwesomeKhatma() -> Font{
        let size:CGFloat = isIpad ? 20 : 15
        return Font.custom("FontAwesome", size: size)
    }
    
    static func fontAwesome6Khatma() -> Font{
        let size:CGFloat = isIpad ? 20 : 15
        return Font.custom("FontAwesome6Free-Solid", size: size)
    }
    
    static func fontAwesomeLock() -> Font{
        let size:CGFloat = isIpad ? 20 : 15
        return Font.custom("FontAwesome", size: size)
    }
    
    static func fontAwesomeSmallLock() -> Font{
        let size:CGFloat = isIpad ? 16 : 12
        return Font.custom("FontAwesome", size: size)
    }
}
 
@MainActor
struct Heights {
    static func header() -> CGFloat{
        let height:CGFloat = isIpad ? 80 : 60
        return height
    }
}
