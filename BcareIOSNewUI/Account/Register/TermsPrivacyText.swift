//
//  TermsPrivacyText.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/28/24.
//

import Foundation

import SwiftUI

struct TermsPrivacyText: View {
  @EnvironmentObject var coordinator: Coordinator
  let string = "ByClicking".localized + " " + "TermsAndConditions".localized + " " + "WhichWe".localized + " " + "PrivacyPolicy".localized + " " + "IAcknowledgeThat".localized
  enum TermsOrPrivacySheet: Identifiable {
    case terms, privacy
    var id: Int {
      hashValue
    }
  }
  func getTerms() -> [String] {
      return isAr ? ["الشروط‏", "والأحكام"] : ["Terms", "&", "Conditions"]
  }
  func getPrivacy() -> [String] {
      return isAr ? ["الخصوصية", "سياسة"] : ["Privacy", "policy"]
  }
  func showSheet(_ string: String) {
    if getTerms().contains(string) {
        coordinator.push(TermsPrivacyItem(url: termsConditionsLink))
    }
    else if getPrivacy().contains(string) {
       coordinator.push(TermsPrivacyItem(url: privacyPolicyLink))
    }
  }
  func drawColor(_ string: String) -> Color {
    let res = getTerms() + getPrivacy()
    return res.contains(string) ? appBlueColor : appBlueColor.opacity(0.5)
  }
  func drawFont(_ string: String) -> Font {
     let res = getTerms() + getPrivacy()
     return res.contains(string) ? Fonts.tooSmallMedium() : Fonts.tooSmallLight()
  }
  private func createText(maxWidth: CGFloat) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    let stringArray = string.components(separatedBy: " ").map { DrawTermsPrivacyItem(text: $0) }
    return ZStack(alignment: .topLeading) {
          ForEach(Array(stringArray.enumerated()), id: \.element.identifier) { index,string in
              Text(string.text + " ")
                  .font(drawFont(string.text))
                  .foregroundColor(drawColor(string.text))
                  .onTapGesture { showSheet(string.text) }
            .alignmentGuide(.leading, computeValue: { dimension in
              if (abs(width - dimension.width) > maxWidth) {
                width = 0
                height -= dimension.height
              }
              let result = width
                if string.text == stringArray.last?.text {
                width = 0
              }
              else {
                width -= dimension.width
              }
              return result
            })
            .alignmentGuide(.top, computeValue: { dimension in
              let result = height
                if string.text == stringArray.last?.text { height = 0 }
              return result
            })
          }
      }
      .frame(maxWidth: .infinity, alignment: .topLeading)
    }
  let width:CGFloat
  var body: some View {
       createText(maxWidth: width)
      .frame(maxWidth: .infinity)
  }
}

struct DrawTermsPrivacyItem:Equatable,Hashable {
    let text:String
    var identifier: String {
        return UUID().uuidString
    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    public static func == (lhs: DrawTermsPrivacyItem, rhs: DrawTermsPrivacyItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
