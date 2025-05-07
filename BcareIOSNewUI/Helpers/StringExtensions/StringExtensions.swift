//
//  StringExtensions.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation

extension String {
    var addAsterisks:String {
        let first = self.substring(to: 2)
        let last = self.substring(from: self.count - 4)
        return isAr ? last + "****" + first : first + "****" + last
    }
    var encrypted:String {
        return encrypt(self)!
    }
    var encryptedOther:String {
        return encryptOther(self)!
    }
    var localized:String {
        return languageBundle!.localizedString (forKey:self, value: "", table: nil)
    }
    var linesToSpaces:String {
        return self.replacingOccurrences(of: "\n", with: " ")
    }
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        let first = index(from: 0)
        return String(self[first..<toIndex])
    }
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    var htmlToAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    var addZeros: String {
        return (0..<(4-self.count)).map { _ in "0" }.joined(separator: "") + self
    }
    var removeZero: String {
        return substring(from: 1)
    }
    // date string to localized name
    var monthName:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier:"en_US")
        let date = formatter.date(from: self)!
        formatter.dateFormat = "MMM yyyy"
        formatter.locale = Locale(identifier: isAr ? "ar_EG" : "en_US")
        let name = formatter.string(from: date)
        return name
    }
    // date string to localized name
    var dateDayNum:(String,String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier:"en_US")
        let date = formatter.date(from: self)!
        formatter.dateFormat = "EEE"
        formatter.locale = Locale(identifier: isAr ? "ar_EG" : "en_US")
        let name = formatter.string(from: date)
        formatter.dateFormat = "d"
        let number = formatter.string(from: date)
        return (name,number)
    }
    // Email validation
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    // Phone validation
    func isValidPhone() -> Bool {
        let emailRegEx = #"^(009665|9665|\+9665|05)(5|0|3|6|4|9|1|8|7)([0-9]{7})$"#
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }
    // PlateNumber validation
    func isValidPlateNumber() -> Bool {
        return count <= 4
    }
    // PlateLetters validation
    func isValidPlateLetters() -> Bool {
        return count <= 3 && CharacterSet.letters.isSuperset(of: CharacterSet(charactersIn: self))
    }
    // National id validation
    func isValidNational() -> Bool {
        if self.count != 10 {
            return false
        }
        if !self.starts(with: "1") && !self.starts(with: "2") && !self.starts(with: "7") {
            return false
        }
        var sum = 0
        for i in 0..<10 {
            if i % 2 == 0 {
                let value = String(format: "%02d", Int(String(self[self.index(self.startIndex, offsetBy: i)]))! * 2)
                sum += Int(String(value[value.startIndex]))! + Int(String(value[value.index(value.startIndex, offsetBy: 1)]))!
            } else {
                sum += Int(String(self[self.index(self.startIndex, offsetBy: i)]))!
            }
        }
        return sum % 10 == 0
    }
    // Password validation
    func isValidPassword() -> Bool {
        return self.count >= 8
    }
    // First and last names
    func firstLastName() -> String {
        let parts = self.components(separatedBy: " ")
        return parts.first! + " " + parts.last!
    }
    // First name
    func firstName() -> String {
        return self.components(separatedBy: " ").first!
    }
    // last names
    func lastName() -> String {
        return self.components(separatedBy: " ").last!
    }
    // Vin validation
    func isValidSequence() -> Bool {
        return (5...10).contains(self.count)
    }
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    func substring(_ r: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        let indexRange = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
        return String(self[indexRange])
    }
    func separeteString (wordLength : Int ) -> (String ,String ) {
        let firstWord = self.components(separatedBy: " ").first
        var lastWord  : String? = ""
        if firstWord!.count <  wordLength{
           lastWord  =  substring(firstWord!.count..<wordLength)
        }
        return (firstWord!,lastWord!)
    }
    var isNumber: Bool {
          let characters = CharacterSet.decimalDigits.inverted
          return !self.isEmpty && rangeOfCharacter(from: characters) == nil
    }
    public var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        print("converted_value \(str)")
        return str
    }
    subscript(_ i: Int) -> String {
      let idx1 = index(startIndex, offsetBy: i)
      let idx2 = index(idx1, offsetBy: 1)
      return String(self[idx1..<idx2])
    }
    subscript (r: Range<Int>) -> String {
      let start = index(startIndex, offsetBy: r.lowerBound)
      let end = index(startIndex, offsetBy: r.upperBound)
      return String(self[start ..< end])
    }
    subscript (r: CountableClosedRange<Int>) -> String {
      let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
      let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
      return String(self[startIndex...endIndex])
    }
    func getDateTimeHijri(date: String?) -> String  {
        if date != nil && date != ""
        {
        let islamicFormatter = DateFormatter()
        islamicFormatter.dateFormat = "dd/MM/yy hh:mm:ss a"
        islamicFormatter.calendar = Calendar(identifier: .islamic)
        let gregorianFormatter = DateFormatter()
       gregorianFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//          do {
            var dateTime = gregorianFormatter.date(from: date!)
            if dateTime == nil {
                gregorianFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                dateTime = gregorianFormatter.date(from: date!)
            }
            if dateTime != nil {
                  let  islamicString = islamicFormatter.string(from: dateTime!)
                  return islamicString.replacedArabicDigitsWithEnglish;
            }
//          }
//          catch let error {
//              print(error.localizedDescription)
//          }
            if let date = gregorianFormatter.date(from: date!) {
            let  islamicString = islamicFormatter.string(from: date)
          return islamicString;
        } else {
            //print("I couldn't parse \(date)")
        }
    }
        return "";
    }
    func toUtcDate() -> Date? {
       let formatter = DateFormatter()
       formatter.timeZone = TimeZone(identifier: "UTC")
       formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
       return formatter.date(from: self)
    }
}
