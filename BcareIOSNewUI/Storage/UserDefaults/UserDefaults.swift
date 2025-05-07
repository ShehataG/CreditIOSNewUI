//
//  UserUserDefaults.standard.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation

//@MainActor let defaults = UserDefaults.standard // UserDefaults(suiteName: "group.com.bcare.app")!

nonisolated(unsafe) var languageBundle = Bundle(path: Bundle.main.path (forResource:currentKey, ofType: "lproj")!)

extension UserDefaults {
    func set(date: Date, forKey key: String) {
        self.set(date.timeIntervalSince1970.toString(), forKey: key)
    }
    func date(forKey key: String) -> Date? {
        if let res = string(forKey: key) {
            return Date(timeIntervalSince1970:Double(res)!)
        }
       return nil
    }
    func setObject<T:Codable>(type: T, forKey key: String) {
        let data = try! JSONEncoder().encode(type)
        self.set(data, forKey: key)
    }
    func getObject<T:Codable>(forKey key: String) -> T? {
        if let data = data(forKey: key) {
            do {
                let res = try JSONDecoder().decode(T.self, from: data)
                return res
            }
            catch {
                print("DecodeObjectError",error)
            }
        }
       return nil
    }
}

var currentKey:String? {
    get {
        return UserDefaults.standard.string(forKey: "langKey")
    }
    set {
        UserDefaults.standard.set(newValue!, forKey: "langKey")
    }
}

var permissionsDone:Bool {
    get {
        return UserDefaults.standard.bool(forKey: "permissionsDone")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "permissionsDone")
    }
}

var splashPagesShowed:Bool {
    get {
        return UserDefaults.standard.bool(forKey: "splashPagesShowed")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "splashPagesShowed")
    }
}

var splashPermissionsShowed:Bool {
    get {
        return UserDefaults.standard.bool(forKey: "splashPermissionsShowed")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "splashPermissionsShowed")
    }
}

var isCorporate:Bool? {
    get {
        return UserDefaults.standard.bool(forKey: "isCorporate")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "isCorporate")
    }
}

var isCorporateAdmin:Bool? {
    get {
        return UserDefaults.standard.bool(forKey: "IsCorporateAdmin")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "IsCorporateAdmin")
    }
}

var userAccessToken:String? {
    get {
        return UserDefaults.standard.string(forKey: "userAccessToken")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "userAccessToken")
    }
}

var tokenExpirationDate:String? {
    get {
        return UserDefaults.standard.string(forKey: "tokenExpirationDate")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "tokenExpirationDate")
    }
}

var expiryDate:Date? {
    get {
        return UserDefaults.standard.date(forKey: "expiryDate")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "expiryDate")
    }
}

var userEmail:String? {
    get {
        return UserDefaults.standard.string(forKey: "userEmail")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "userEmail")
    }
}

//var userPoliciesCount:Int {
//    get {
//        return UserDefaults.standard.integer(forKey: "userPoliciesCount")
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "userPoliciesCount")
//    }
//}

var userPassword:String? {
    get {
        return UserDefaults.standard.string(forKey: "userPassword")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "userPassword")
    }
}

var isLoggedIn:Bool {
    get {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "isLoggedIn")
    }
}

var userId:String? {
    get {
        return UserDefaults.standard.string(forKey: "userId")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "userId")
    }
}

var userNationalId:String? {
    get {
        return UserDefaults.standard.string(forKey: "userNationalId")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "userNationalId")
    }
}

var userBirthYear:String? {
    get {
        return UserDefaults.standard.string(forKey: "userBirthYear")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "userBirthYear")
    }
}

var userBirthMonth:String? {
    get {
        return UserDefaults.standard.string(forKey: "userBirthMonth")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "userBirthMonth")
    }
}

var userBirthMonthIndex:Int? {
    get {
        return UserDefaults.standard.integer(forKey: "userBirthMonthIndex")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "userBirthMonthIndex")
    }
}

var userPhone:String? {
    get {
        return UserDefaults.standard.string(forKey: "userPhone")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "userPhone")
    }
}

var displayNameAr:String? {
    get {
        return UserDefaults.standard.string(forKey: "displayNameAr")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "displayNameAr")
    }
}

var displayNameEn:String? {
    get {
        return UserDefaults.standard.string(forKey: "displayNameEn")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "displayNameEn")
    }
}

var fullDisplayNameAr:String? {
    get {
        return UserDefaults.standard.string(forKey: "fullDisplayNameAr")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "fullDisplayNameAr")
    }
}
  
var fullDisplayNameEn:String? {
    get {
        return UserDefaults.standard.string(forKey: "fullDisplayNameEn")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "fullDisplayNameEn")
    }
}

var isRenewel:String? {
    get {
        return UserDefaults.standard.string(forKey: "isRenewel")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "isRenewel")
    }
}

var canUpdateProfile:Bool {
    get {
        if let dic = UserDefaults.standard.dictionary(forKey: "canUpdateProfile") as? [String:Bool] {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            let value = formatter.string(from: Date())
            return dic[value] ?? true
        }
        else {
            return true
        }
    }
    set {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let value = formatter.string(from: Date())
        UserDefaults.standard.set([value:newValue], forKey: "canUpdateProfile")
    }
}

var userWareefExpiryDate:String? {
    get {
        return UserDefaults.standard.string(forKey: "userWareefExpiryDate")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "userWareefExpiryDate")
    }
}

var motorVehicles:[AddCarItem]? {
    get {
        return UserDefaults.standard.getObject(forKey: "motorVehicles")
    }
    set {
        UserDefaults.standard.setObject(type: newValue, forKey: "motorVehicles")
    }
}

var userBeginLoginItem:BeginLoginItem? {
    get {
        return UserDefaults.standard.getObject(forKey: "userBeginLoginItem")
    }
    set {
        UserDefaults.standard.setObject(type: newValue, forKey: "userBeginLoginItem")
    }
}
 
var userSanarItem:UserSanarItem? {
    get {
        return UserDefaults.standard.getObject(forKey: "userSanarItem")
    }
    set {
        UserDefaults.standard.setObject(type: newValue, forKey: "userSanarItem")
    }
} 
