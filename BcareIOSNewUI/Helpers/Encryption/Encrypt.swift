//
//  Encrypt.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 28/05/2024.
//

import Foundation
import CommonCrypto
import CryptoKit

let encryptKey = "BcARe_2021_N0MeM"
let encryptIv = "BcARe_2021_N0MeM"

func encrypt(_ plainText: String, key: String = encryptKey , iv: String = encryptIv) -> String? {
    guard let keyData = key.data(using: .utf8), let ivData = iv.data(using: .utf8) else {
          return nil
    }
    var encryptedData = Data(count: plainText.count + kCCBlockSizeAES128)
    var encryptedLength: size_t = 0
    let status = keyData.withUnsafeBytes { keyBytes in
        ivData.withUnsafeBytes { ivBytes in
            plainText.withCString { plainTextBytes in
                CCCrypt(
                    CCOperation(kCCEncrypt),
                    CCAlgorithm(kCCAlgorithmAES),
                    CCOptions(kCCOptionPKCS7Padding),
                    keyBytes.baseAddress,
                    key.count,
                    ivBytes.baseAddress,
                    plainTextBytes,
                    plainText.count,
                    encryptedData.withUnsafeMutableBytes { $0.baseAddress },
                    encryptedData.count,
                    &encryptedLength
                )
            }
        }
    }
    if status == kCCSuccess {
        encryptedData.removeSubrange(encryptedLength..<encryptedData.count)
        return encryptedData.base64EncodedString()
    } else {
        return nil
    }
}
   

func encryptOther(_ plainText: String) -> String? {
    let hashKey = "bC@Re_2020_N0MeTecH_hAsHKEy"
    // Generate AES key and IV from the hashKey
        let key = Array(hashKey.padding(toLength: 32, withPad: " ", startingAt: 0).utf8)
        let iv = Array(hashKey.prefix(16).utf8)
        // Perform encryption
        let encryptedBytes = AES.encrypt(Array(plainText.utf8), key: key, iv: iv)
        // Return the base64 encoded encrypted string
        return Data(encryptedBytes).base64EncodedString()
    }

struct AES {
    static func encrypt(_ data: [UInt8], key: [UInt8], iv: [UInt8]) -> [UInt8] {
        return crypt(data: data, key: key, iv: iv, operation: CCOperation(kCCEncrypt))
    }
    static func crypt(data: [UInt8], key: [UInt8], iv: [UInt8], operation: CCOperation) -> [UInt8] {
        var outLength = Int(0)
        var outData = [UInt8](repeating: 0, count: data.count + kCCBlockSizeAES128)
        let status = CCCrypt(
            operation,
            CCAlgorithm(kCCAlgorithmAES128),
            CCOptions(kCCOptionPKCS7Padding),
            key,
            key.count,
            iv,
            data,
            data.count,
            &outData,
            outData.count,
            &outLength
        )
        if status == kCCSuccess {
            return Array(outData.prefix(outLength))
        } else {
            fatalError("Encryption failed")
        }
    }
}
