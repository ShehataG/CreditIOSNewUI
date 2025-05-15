//
//  TextInputView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine

struct CheckView: View {
    var isChecked:Binding<Bool>
    var isError:Binding<Bool>
    let imgWid:CGFloat = isIpad ? 40 : 30
    var body: some View {
        ZStack {
            if isChecked.wrappedValue {
                FAText(text: FontAwesome.correctIcon,color: Color.white,font: Fonts.fontAwesome15_20())
            }
        }
        .frame(width:imgWid,height:imgWid)
        .background(isChecked.wrappedValue ? appBlueColor : Color.lightGrayCommon)
        .cornerRadiusWithBorder(radius: 5,borderColor: isError.wrappedValue ? Color.red : appGreenColor)
        .onTapGesture {
            isChecked.wrappedValue = !isChecked.wrappedValue 
        }
    }
}
