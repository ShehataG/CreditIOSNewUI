//
//  HTTPClient.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/26/24.
//

import Foundation

let AppURL = "https://bcare.com.sa/"
let MedicalURL = "https://medical.bcare.com.sa/"
let TravelURL = "https://travel.bcare.com.sa/"
let MalpracticesURL = "https://mm.bcare.com.sa/"
let GoogleGeo = "https://maps.googleapis.com/"
let AppStagingURL = "https://staging.bcare.com.sa/"

let google_key_ios_geocode = "AIzaSyAkrYyBij7qnC6xwK3YvrdXjJkL8hrguHo"
let google_key_ios_google_map = "AIzaSyBnxyZuV4B8gBTmKVcIVKDVeRLQ5_oqZ3c"
let google_key_android_geocode_ = "AIzaSyCGrtWyAJhyEPWF3JI0F2lTyPbUGLXqTIo"
let google_key_android_google_map = "AIzaSyDSiIoyh0OE9onqwwCouHCqedhgHd5jblI"

@MainActor var FIREBASE_TOKEN:String?

@MainActor var termsConditionsLink:String =  {
    return "\(AppURL)\(isAr ? "" : "en/")termsandconditions/"
}()

@MainActor var privacyPolicyLink:String =  {
    return "\(AppURL)\(isAr ? "" : "en/")privacy-policy/"
}()

public enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

public protocol HTTPClient {
    var host: String { get }
    var path: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
}

enum JSONPlaceholderService {
    case getAccessToken
    case version
    case registerToken
    case beginRegister
    case endRegister
    case verifyRegisterOTP
    case resendOTP
    case beginLogin
    case endLogin
    case verifyLoginOTP
    case beginForgetPassword
    case endForgetPassword
    case verifyYakeenMobile
    case logout
    case profileByType
    case googleGeocode
    case getVehiclesByNin
    case sendOTP
    case updateUserProfileData 
    case verifyForgetPasswordOTP
    case confirmResetPassword
    case category
    case categoryItemByCategoryId
    case appleCard
    case getCaptcha
    case getAvailableDaysSlots
    case getOwnerVehicles
    case createBooking
    case cancelBooking
    case getSingleBookingDetails
    case getBookingsPerClient
    case checkoutWithApplePay
    case paymentStatus
    case createBookingWithPayment
    case checkForOffers
    case mainService
    case createOrder
    case mojazInquiry
    case setPaymentStatus
    case orders
    case getVehiclesInfo
    case addCar
    case checkVehiclesBySequenceNumber
    case getAllUserActivePolicies
    case isAuthenticated
    case getUserDetails
    case getServiceAmount
    case downloadPolicyFile
    case getPolicyDetailsByNumber
    case getTokenByUserId
    case mojazFile
    case mojazCompleteInfosByNationalId
    case getAllActiveCompaniesServices
    case createBookingViaSweaterGateway
    case sweaterPaymentGatewayCallback
}

extension JSONPlaceholderService: HTTPClient {
    var host: String {
        switch self { 
            case .googleGeocode:
                return GoogleGeo
            default:
                return AppURL
        }
    }
    var path: String {
        switch self {
            case .getAccessToken,.getCaptcha:
                return "CaptchaApi/api/"
        case .beginRegister,.endRegister,.verifyRegisterOTP,.resendOTP,.beginLogin,.endLogin,.verifyLoginOTP,.beginForgetPassword,.endForgetPassword,.verifyYakeenMobile,.logout,.verifyForgetPasswordOTP,.confirmResetPassword,.registerToken,.isAuthenticated,.getTokenByUserId:
                    return "identityapi/api/identity/"
        case .profileByType,.sendOTP,.updateUserProfileData,.checkForOffers,.downloadPolicyFile:
                    return "identityAPI/api/profile/"
            case .googleGeocode:
                return "maps/api/geocode/"
            case .getVehiclesByNin:
                return "InquiryApi/api/InquiryNew/"
            case .category,.categoryItemByCategoryId,.appleCard:
                return "GenericApi/api/wareef/"
        case .getAvailableDaysSlots,.getOwnerVehicles,.createBooking,.cancelBooking,.getSingleBookingDetails,.getBookingsPerClient,.createBookingWithPayment,.getVehiclesInfo,.addCar,.checkVehiclesBySequenceNumber,.createBookingViaSweaterGateway,.sweaterPaymentGatewayCallback:
                return "StagingIntegrationApi/api/sweater/"
            case .checkoutWithApplePay,.paymentStatus:
                return "StagingIntegrationApi/api/Hyperpay/"
        case .mainService,.createOrder,.orders:
            return "StagingIntegrationApi/api/Ezhalha/"
        case .mojazInquiry,.mojazFile,.mojazCompleteInfosByNationalId:
            return "MojazIntegration/api/Mojaz/"
        case .setPaymentStatus:
            return "StagingIntegrationApi/api/Mojaz/"
        case .version,.getUserDetails,.getServiceAmount,.getAllUserActivePolicies,.getAllActiveCompaniesServices:
            return "StagingIntegrationApi/api/Common/"
        case .getPolicyDetailsByNumber:
            return "identity/api/Profile/"
        }
    }
    var endpoint: String {
        switch self {
            case .getAccessToken:
                return "GetAccessToken"
            case .version:
                return "LatestAppVersion"
            case .registerToken:
                return "RegisterToken"
            case .beginRegister:
                return "beginregister"
            case .endRegister:
                return "endregister"
            case .verifyRegisterOTP:
                return "verifyRegisterOTP"
            case .resendOTP:
                return "resendOTP"
            case .beginLogin:
                return "beginlogin"
            case .endLogin:
                return "endlogin"
            case .verifyLoginOTP:
                return "verifyLoginOTP"
            case .beginForgetPassword:
                return "beginForgetPassword"
            case .endForgetPassword:
                return "endForgetPassword"
            case .verifyYakeenMobile:
                return "verifyYakeenMobile"
            case .logout:
                return "Logout"
            case .profileByType:
                return "profileByType"
            case .googleGeocode:
                return "json"
            case .getVehiclesByNin:
                return "getVehiclesByNin"
            case .sendOTP:
                return "sendOTP"
            case .updateUserProfileData:
                return "updateUserProfileData"
            case .verifyForgetPasswordOTP:
                return "verifyForgetPasswordOTP"
            case .confirmResetPassword:
                return "confirmResetPassword"
            case .category:
                return "Category"
            case .categoryItemByCategoryId:
                return "CategoryItemByCategoryId?"
            case .appleCard:
                return "appleCard"
            case .getCaptcha:
                return "GetCaptcha"
            case .getAvailableDaysSlots:
                return "GetAvailableDaysSlots"
            case .getOwnerVehicles:
                return "GetOwnerVehicles"
            case .createBooking:
                return "CreateBooking"
            case .cancelBooking:
                return "CancelBooking"
            case .getSingleBookingDetails:
                return "GetSingleBookingDetails"
            case .getBookingsPerClient:
                return "GetBookingsPerClient"
            case .checkoutWithApplePay:
                return "CheckoutWithApplePay"
            case .paymentStatus:
                return "PaymentStatus"
            case .createBookingWithPayment:
                return "CreateBookingWithPayment"
            case .checkForOffers:
                return "checkForOffers"
            case .mainService:
                return "MainService"
            case .createOrder:
                return "CreateOrder"
            case .mojazInquiry:
                return "MojazInquiry"
            case .setPaymentStatus:
                return "SetPaymentStatus"
            case .orders:
                return "orders"
            case .getVehiclesInfo:
                return "GetVehiclesInfo"
            case .addCar:
                return "AddCar"
            case .checkVehiclesBySequenceNumber:
                return "CheckVehiclesBySequenceNumber"
            case .getAllUserActivePolicies:
                return "GetAllUserActivePolicies"
            case .isAuthenticated:
                    return "IsAuthenticated"
            case .getUserDetails:
                    return "GetUserDetails"
            case .getServiceAmount:
                    return "GetServiceAmount"
            case .downloadPolicyFile:
                return "DownloadPolicyFile"
            case .getPolicyDetailsByNumber:
                return "GetPolicyDetailsByNumber"
            case .getTokenByUserId:
                return "GetTokenByUserId"
            case .mojazFile:
                return "mojazFile"
            case .mojazCompleteInfosByNationalId:
                return "MojazCompleteInfosByNationalId"
            case .getAllActiveCompaniesServices:
                return "GetAllActiveCompaniesServices"
            case .createBookingViaSweaterGateway:
                return "CreateBookingViaSweaterGateway"
            case .sweaterPaymentGatewayCallback:
                return "SweaterPaymentGatewayCallback"
            
        }
    }
    var method: HTTPMethod {
        switch self {
        case .registerToken,.getAccessToken,.beginRegister,.endRegister,.verifyRegisterOTP,.resendOTP,.beginLogin,.endLogin,.verifyLoginOTP,.beginForgetPassword,.endForgetPassword,.verifyYakeenMobile,.logout,.sendOTP,.updateUserProfileData,.verifyForgetPasswordOTP,.confirmResetPassword,.category,.categoryItemByCategoryId,.appleCard,.getAvailableDaysSlots,.createBooking,.cancelBooking,.getSingleBookingDetails,.getBookingsPerClient,.checkoutWithApplePay,.paymentStatus,.createBookingWithPayment,.checkForOffers,.createOrder,.mojazInquiry,.setPaymentStatus,.addCar,.checkVehiclesBySequenceNumber,.createBookingViaSweaterGateway:
            return .post
        case .version,.profileByType,.googleGeocode,.getVehiclesByNin,.getCaptcha,.getOwnerVehicles,.mainService,.orders,.getVehiclesInfo,.getAllUserActivePolicies,.isAuthenticated,.getUserDetails,.getServiceAmount,.downloadPolicyFile,.getPolicyDetailsByNumber,.getTokenByUserId,.mojazFile,.mojazCompleteInfosByNationalId,.getAllActiveCompaniesServices,.sweaterPaymentGatewayCallback:
            return .get
        }
    }
    var headers: [String : String]? {
        let bundleId = Bundle.main.bundleIdentifier!
        var value = [
            "Content-type": "application/json",
            "Accept-Language": langText,
        ]
        if path.contains("StagingIntegrationApi") { // StagingIntegrationApi
            value["x-api-key"] = "QFSy34YV0pAlTieNkvayNBGF5hmlt21DZ8C9vtvR7Ko="
        }
        else if path.contains("MojazIntegration") {
        }
        else {
            if let token = userAccessToken {
                value["Authorization"] = "Bearer \(token)"
            }
            value["X-Ios-Bundle-Identifier"] = bundleId
        }
        print(endpoint  + " " + " Headers:- ",value)
        return value
    }
}

enum HTTPClientError: Error {
    case badURL
    case noAuth
}

extension HTTPClient {
    fileprivate var url: String {
//        if path.contains("StagingIntegrationApi") {
//            return AppStagingURL + path + endpoint
//        }
//        else {
            return host + path + endpoint
//        }
    }
    func request<T: Codable>(type: T.Type, parameters: [String : Any]? = nil) async -> (Result<T, Error>,ErrorItem?) {
        var request:URLRequest!
        if let parameters = parameters {
            print(endpoint + " " + " Body:- ",parameters)
            if method == .post {
                let param = addGlobalKeys(parameters)!
                do {
                    // This part for CategoryItemByCategoryId as it's post method while it has get parameters
                    var url = url
                    if url.contains("?") {
                        url = url + parameters.toQueryStringParams()
                    }
                    // Ends here
                    guard let url = URL(string: url) else {
                        return (.failure(HTTPClientError.badURL), nil)
                    }
                    request = URLRequest(url: url)
                    request.httpBody = try JSONSerialization.data(withJSONObject: param, options: [])
                    print(param)
                } catch {
                    return(.failure(error), nil)
                }
            }
            else {
                let res = url + "?" + parameters.toQueryStringParams()
                guard let url = URL(string: res) else {
                    return(.failure(HTTPClientError.badURL), nil)
                }
                request = URLRequest(url: url)
            }
        }
        else {
            guard let url = URL(string: url) else {
                return(.failure(HTTPClientError.badURL), nil)
            }
            request = URLRequest(url: url)
        }
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        print("Calling:- ",request.url!.absoluteString)
        do {
            let (data, response) = try await session.data(for: request)
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            print(endpoint + " " + "\(String(describing: statusCode))")
            if  statusCode == 401 {
                Task {
                    await UserManager.sessionExpired()
                }
                return (.failure(HTTPClientError.noAuth),nil)
            }
            do {
                print(endpoint + " Data:- " + " \(data.toJsonStr())")
                return (.success(try JSONDecoder().decode(type, from: data)), nil)
            } catch {
                print(endpoint + " Error Data Custom:- \(error)")
                do {
                    return (.failure(error),try JSONDecoder().decode(ErrorItem.self, from: data))
                } catch {
                    print(endpoint + " Error Global Custom:- \(error)")
                    return (.failure(error),nil)
                }
            }
        }
        catch {
            return (.failure(error), nil)
        }
    }
    func getFileData(parameters: [String : Any]? = nil) async -> (Result<Data, Error>,ErrorItem?) {
        var request:URLRequest!
        if let parameters = parameters {
            if method == .post {
                do {
                    let param = addGlobalKeys(parameters)!
                    guard let url = URL(string: url) else {
                        return(.failure(HTTPClientError.badURL), nil)
                    }
                    request = URLRequest(url: url)
                    request.httpBody = try JSONSerialization.data(withJSONObject: param, options: [])
                    print(param)
                } catch {
                    return (.failure(error), nil)
                }
            }
            else {
                let res = url + "?" + parameters.toQueryStringParams()
                guard let url = URL(string: res) else {
                    return (.failure(HTTPClientError.badURL), nil)
                }
                request = URLRequest(url: url)
            }
        }
        else {
            guard let url = URL(string: url) else {
                return (.failure(HTTPClientError.badURL), nil)
            }
            request = URLRequest(url: url)
        }
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        print("Calling:- ",request.url!.absoluteString)
        do {
            let (data, response) = try await session.data(for: request)
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            print(endpoint + " " + "\(String(describing: statusCode))")
            if  statusCode == 401 {
                Task {
                    await UserManager.sessionExpired()
                }
                return (.failure(HTTPClientError.noAuth),nil)
            }
            return (.success(data),nil)
        }
        catch {
            return (.failure(error), nil)
        }
    }
    func addGlobalKeys(_ parameters:[String:Any]?) -> [String:Any]? {
        var params = parameters
        params?["channel"] = "ios"
        params?["mobileVersion"] = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        return params
    }
}
extension Data {
    func toJsonStr() -> String {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return String(data: data, encoding: .utf8)!
         } catch {
            return "Decode error"
        }
    }
}
