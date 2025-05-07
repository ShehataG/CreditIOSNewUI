//
//  HeaderView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    let text:String
    var body: some View {
        Text(verbatim:text.localized)
            .font(Fonts.mediumRegular())
            .foregroundColor(Color.white)
            .padding(.top,5)
            .padding(.bottom,35)
    }
}
  
struct HeaderWithBackView: View {
    @Environment(\.presentationMode) var presentationMode
    let color:Color
    let text:String
    init(text: String,color: Color = Color.white) {
        self.color = color
        self.text = text
    }
    
    var body: some View {
        ZStack {
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
            Text(verbatim:text.localized)
                .font(Fonts.mediumRegular())
                .foregroundColor(Color.white)
        } 
        .padding(.top,5)
        .padding(.bottom,35)
    }
}

struct HeaderWithBackDownView: View {
    @Environment(\.presentationMode) var presentationMode
    let color:Color
    let text:String
    var downloadClicked:(()->())?
    init(text: String,color: Color = Color.white,downloadClicked:(()->())?) {
        self.color = color
        self.text = text
        self.downloadClicked = downloadClicked
    }
    
    var body: some View {
        ZStack {
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
                Button {
                } label: {
                    FAText(text: FontAwesome.downloadIcon,color: Color.white)
                        .padding(.horizontal,20)
                        .onTapGesture {
                            downloadClicked?()
                        }
                }
            }
            Text(verbatim:text.localized)
                .font(Fonts.mediumRegular())
                .foregroundColor(Color.white)
        }
        .padding(.top,5)
        .padding(.bottom,35)
    }
}
  
struct HeaderWithBackKeyboardView: View {
    @Environment(\.presentationMode) var presentationMode
    let color:Color
    let text:String
    let showKeyboard:Bool
    var keyboardClicked:(()->())?
    init(text: String,showKeyboard:Bool = false,color: Color = Color.white,keyboardClicked:(()->())?) {
        self.color = color
        self.text = text
        self.showKeyboard = showKeyboard
        self.keyboardClicked = keyboardClicked
    }
    
    var body: some View {
        ZStack {
            HStack {
                Button {
                } label: {
                    FAText(text: FontAwesome.backIcon,color: color)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                Spacer()
            }
            Text(verbatim:text.localized)
                .font(Fonts.mediumRegular())
                .foregroundColor(Color.white)
            if showKeyboard {
                HStack {
                    Spacer()
                    Button {
                    } label: {
                        FAText(text: FontAwesome.keyboardIcon)
                            .onTapGesture {
                                keyboardClicked?()
                            }
                    }
                }
            }
        }
        .padding(.horizontal,20)
        .padding(.top,5)
        .padding(.bottom,35)
    }
}
