//
//  HelpView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import  SwiftUI

struct HelpView: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.presentationMode) var presentationMode
    let imgArrowWid:CGFloat = isIpad ? 60.0 : 50.0
    let ezhelhaServiceNumber = "920005241"
    let ezhelhaWhats = "+966112775970"
    var body: some View {
        ZStack {
            PlaceholderView()
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Image("closebacked")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imgArrowWid,height: imgArrowWid)
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                    VStack(spacing:20) {
                        HelpListView(title: "CallUs",icon: FontAwesome.callIcon)
                            .onTapGesture {
                                if let url = URL(string: "tel://\(ezhelhaServiceNumber)") {
                                    UIApplication.shared.open(url, options: [:], completionHandler:nil)
                                }
                            }
                        HelpListView(title: "ContactUsWhats",icon: FontAwesome.chatIcon)
                            .onTapGesture {
                                openWhats(ezhelhaWhats)
                            }
                    }
                }
                .colorScheme(.light)
                .padding(.bottom,30)
                .padding(20)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
            }
        }
        .environment(\.layoutDirection, coordinator.layoutDirection)
        .edgesIgnoringSafeArea(.bottom)
    }
}
