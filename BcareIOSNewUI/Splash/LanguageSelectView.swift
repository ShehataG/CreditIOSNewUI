//
//  LanguageSelectView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import SwiftUI
import CoreLocation
import SwiftUIPager
import Combine
import SwiftUI

struct LanguageSelectView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State var chooseText = "ChooseLanguage".localized
    @State var continueText = "Continue".localized
    @State var selected = isAr ? 0 : 1
    var body: some View {
        VStack {
            Text(verbatim:chooseText)
                .font(Fonts.mediumRegular())
                .padding(.top,20)
            Spacer()
            VStack {
                LanguageSelectItemView(image: "saudi", text: "العربية", tag: 0,selected: $selected)
                LanguageSelectItemView(image: "kingdom", text: "English", tag: 1,selected: $selected)
            }
            Spacer()
            RoundedBu(item: continueText, textColor: .white, backColor: appBlueColor, width: 0.8,vPadding: 15)
                .onTapGesture {
                    coordinator.push(Destination.permissionsPage)
                }
        }
        .padding(.horizontal,20)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.white)
        .colorScheme(.light)
        .onChange(of: selected, perform: { _ in
            currentKey = selected == 0 ? "ar" : "en"
            languageBundle = Bundle(path: Bundle.main.path (forResource:currentKey, ofType: "lproj")!)
            chooseText = "ChooseLanguage".localized
            continueText = "Continue".localized
        })
    }
}
 
struct LanguageSelectItemView: View {
    let image,text:String
    let tag:Int
    let imgWid:CGFloat = isIpad ? 50.0 : 30.0
    @Binding var selected:Int
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imgWid,height: imgWid)
            Text(verbatim:text.localized)
                .font(Fonts.smallRegular())
                .foregroundColor(tag == selected ? Color.white : Color.black)
            Spacer()
            if tag == selected {
                Text(verbatim: FontAwesome.checkedIcon)
                    .font(Fonts.fontAwesome())
                    .foregroundColor(Color.white)
            }
        }
        .padding(.horizontal,20)
        .padding(.vertical,20)
        .background(tag == selected ? appOrangeColor.opacity(0.7) : Color.lightGrayMore)
        .cornerRadius(10)
        .tag(tag)
        .onTapGesture {
            selected = tag
        }
    }
}
