//
//  AppDelegate.swift
//  BcareIOSNewUI
//
//  Created by Mac on 11/12/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UserNotifications
import IQKeyboardManagerSwift
import GoogleMaps
import FirebaseCore
import FirebaseMessaging
import AdjustSdk
//import FreshchatSDK
import SiriusRating

@MainActor var isAppOpened = false

class AppDelegate: UIResponder, UIApplicationDelegate {
    static var shared = AppDelegate()
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    let appStoreId = "1490248033"
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        isAppOpened = false
        if currentKey == nil {
            currentKey = NSLocalizedString("Lang", comment: "")
        }
        #if canImport(UIKit)
            UITableView.appearance().showsVerticalScrollIndicator = false
            UIScrollView.appearance().showsVerticalScrollIndicator = false
            UITabBar.appearance().backgroundImage = UIImage.colorForNavBar(color: .clear)
            UITabBar.appearance().shadowImage = UIImage.colorForNavBar(color: .clear)
            UITextField.appearance().keyboardAppearance = .light
        #endif
        return true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(google_key_ios_google_map)
        Task {
            FirebaseApp.configure()
            Messaging.messaging().delegate = self
        }
        IQKeyboardManager.shared.isEnabled = true
        //setFreshChat()
        setAdjust()
        configureRate()
        Task {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            try await UNUserNotificationCenter.current().requestAuthorization(options: authOptions)
            application.registerForRemoteNotifications()
        } 
        return true
        
    }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
//    func setFreshChat() {
//        let freshchatConfig:FreshchatConfig = FreshchatConfig(appID: "YOUR-APP-ID", andAppKey: "d7e94752-e315-416f-8e90-71c87679b05b")
//        freshchatConfig.domain = "https://bcare.com.sa"
//        Freshchat.sharedInstance().initWith(freshchatConfig)
//    }
    func setAdjust() {
      let appToken = "wjxzcrqrsz5s"
      #if DEBUG
//          let adjustConfig = ADJConfig(
//              appToken: appToken,
//              environment: ADJEnvironmentSandbox)
//          adjustConfig?.logLevel = ADJLogLevel.verbose
//          Adjust.initSdk(adjustConfig)
      #else
          let adjustConfig = ADJConfig(
              appToken: appToken,
              environment: ADJEnvironmentProduction)
          adjustConfig?.logLevel = ADJLogLevel.suppress
          Adjust.initSdk(adjustConfig)
      #endif
    }
    func configureRate() {
      let debugMode:Bool
      #if DEBUG
        debugMode = true
      #else
        debugMode = false
      #endif
      SiriusRating.setup(
            requestPromptPresenter: StyleOneRequestPromptPresenter(),
            debugEnabled: debugMode,
            ratingConditions: [
                EnoughDaysUsedRatingCondition(totalDaysRequired:5),
                EnoughAppSessionsRatingCondition(totalAppSessionsRequired:4),
                EnoughSignificantEventsRatingCondition(significantEventsRequired:5),
                NotPostponedDueToReminderRatingCondition(totalDaysBeforeReminding:14),
                NotDeclinedToRateAnyVersionRatingCondition(daysAfterDecliningToPromptUserAgain: 30, backOffFactor: 2.0, maxRecurringPromptsAfterDeclining: 2),
                NotRatedCurrentVersionRatingCondition(),
                NotRatedAnyVersionRatingCondition(daysAfterRatingToPromptUserAgain: 240, maxRecurringPromptsAfterRating: UInt.max)
            ],
            canPromptUserToRateOnLaunch: true,
            didOptInForReminderHandler: {
            },
            didDeclineToRateHandler: {
            },
            didRateHandler: {
            }
        )
    }
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }
      processNo(userInfo)
      print(userInfo)
    }
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }
      processNo(userInfo)
      print(userInfo)
      return UIBackgroundFetchResult.newData
    }
//    func application(
//        _ application: UIApplication,
//        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
//        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//        processNo(userInfo)
//        print(userInfo)
//        completionHandler(UIBackgroundFetchResult.newData)
//    }
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//      print("APNs token retrieved: \(deviceToken)")
       let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
       let token = tokenParts.joined()
       print("Device Token: \(token)")
    }
    // For Hyperpay Disable third party keyboards.
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        if (extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard) {
            return false
        }
        return true
    } 
}
extension AppDelegate {
    func registerToken() {
        guard let userId = userId,let token = FIREBASE_TOKEN , isValidToken() else { return }
        let parameters = ["userId": userId,"token":token]
        Task {
            let (result,error) = await JSONPlaceholderService.registerToken.request(type: RegisterTokenItem.self,parameters: parameters)
            switch result {
            case .success(let result):
                print(result)
                break
            case .failure(_):
                if let error = error {
                    print(error)
                }
                break
            }
        }
    }
    func isValidToken() -> Bool {
        if let _ = userAccessToken , let tokenExpirationDate = tokenExpirationDate ,
           let expiryDate = tokenExpirationDate.toUtcDate() , let current = Date().toUtcDate() {
            print("expiryDate: ",expiryDate)
            print("current: ",current)
            if current < expiryDate {
                return true
            }
        }
        return false
    }
}
extension AppDelegate: @preconcurrency UNUserNotificationCenterDelegate {
      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID1: \(messageID)")
        }
        return[.list, .banner, .sound]
    }
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse) async {
//        let userInfo = response.notification.request.content.userInfo
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID2: \(messageID)")
//        }
//        processNo(userInfo)
//    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID2: \(messageID)")
        }
        processNo(userInfo)
        completionHandler()
    }
}
extension AppDelegate: @preconcurrency MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        let value = fcmToken ?? ""
        FIREBASE_TOKEN = value
        registerToken()
        let dataDict: [String: String] = ["token": value]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"),object: nil,userInfo: dataDict)
    }
}

@MainActor
func processNo(_ userInfo:[AnyHashable:Any]) {
    if isAppOpened {
       NotificationCenter.default.post(name: .sanarConsultNotification,object: nil,userInfo: userInfo)
    }
    else {
       sanarUserInfo = userInfo
    }
}
