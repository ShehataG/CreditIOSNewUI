//
//  IntExtensions.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation

extension Int {
   func toString() -> String {
       return "\(self)"
   }
   func  toKiloString() -> String {
       if self < 1000 {
            return "\(self)"
       }
       let formatted = String(format: "%.1f",Double(self)/1000.0)
       return "\(formatted)k"
   }
}

extension Double {
    func toString() -> String {
        return "\(self)"
    }
    func valueWithoutVat() -> Double {
        return self / 1.15
    }
    func withAddedVat() -> Double {
        return  self + self * 0.15
    }
    func vatValue() -> Double {
        return self * 0.15
    }
}

extension Character {
    func toString() -> String {
        return "\(self)"
    }
}


extension Double {
    func decimals(_ nbr: Int) -> String {
        if #available(iOS 15.0, *) {
            return String(self.formatted(.number.precision(.fractionLength(nbr))))
        } else {
            return String(format: "%.\(nbr)f", self)
        }
    }
}
