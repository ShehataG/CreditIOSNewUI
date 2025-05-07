//
//  ImageExtensions.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 7/2/24.
//

import Foundation
import SwiftUI
import SVGKit

extension Image {
    init?(base64String: String) {
        if base64String.contains("data:image/svg+xml;base64,") {
            let result = base64String.replacingOccurrences(of: "data:image/svg+xml;base64,", with: "")
            let dataDecoded = Data(base64Encoded: result, options: .ignoreUnknownCharacters)!
            let decoded = SVGKImage(data:dataDecoded)!
            self = Image(uiImage: decoded.uiImage)
        }
        else {
            let url = URL(string: base64String)!
            let imageData = try! Data(contentsOf: url)
            self = Image(uiImage:UIImage(data: imageData)!)
        }
    }
}

extension UIImage {
    class func colorForNavBar(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.3)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
