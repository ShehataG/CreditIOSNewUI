//
//  DateExtensionsDateExtensions.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 8/1/24.
//

import Foundation

extension Date {
    func toUtcDate() -> Date? {
        let utcCalendar = Calendar(identifier: .gregorian)
        let utcTimeZone = TimeZone(secondsFromGMT: 0)!
        return utcCalendar.date(from: utcCalendar.dateComponents(in: utcTimeZone, from: self))
    }
}
