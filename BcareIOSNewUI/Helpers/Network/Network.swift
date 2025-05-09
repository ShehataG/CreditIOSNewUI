//
//  Network.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/29/24.
//

import Foundation
import SystemConfiguration

func noNetwork() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)}
    } ) else {
        return false
    }
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags)
    {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return !(isReachable && !needsConnection)
}
