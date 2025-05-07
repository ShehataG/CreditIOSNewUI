//
//  BackButton.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 6/9/24.
//

import Foundation
import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode
    let color:Color
    init(color: Color = Color.white) {
         self.color = color
    }
    var body: some View {
        HStack {
            Button {
            } label: {
                FAText(text: FontAwesome.backIcon,color: color)
                    .padding(.horizontal,20)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            Spacer()
        }
    }
}

struct BackPaddedButton: View {
    @Environment(\.presentationMode) var presentationMode
    let imgWid:CGFloat = isIpad ? 30 : 25
    let color:Color   
    let back:Color
    init(color: Color = Color.white,back:Color = Color.lightGrayMid) {
         self.color = color
         self.back = back
    }
    var body: some View {
        HStack {
            Button {
            } label: {
                FAText(text: FontAwesome.backIcon,color: color)
                    .frame(width: imgWid,height: imgWid)
                    .padding(15)
                    .background(Capsule().fill((back)))
                    .padding(.horizontal,10)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                   
             }
            Spacer()
        }
    }
}
