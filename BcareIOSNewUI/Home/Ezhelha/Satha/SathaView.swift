//
//  SathaView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/21/24.
//

import Foundation
import SwiftUI
import Combine
import MapKit

struct SathaView: View {
    @EnvironmentObject var coordinator: Coordinator
    let imgHei:CGFloat = isIpad ? 250.0 : 150.0
    @StateObject var sathaVM = SathaVM()
    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.5)
            VStack {
                HeaderWithBackView(text: "SathaServices".localized.linesToSpaces)
                VStack(spacing:0) {
                    Image("sathaback")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: imgHei)
                        .padding(.bottom,10)
                    let data = sathaVM.data
                    ForEach(data.indices,id: \.self) { row in
                        SathaList(item: data[row])
                    }
                   Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .padding(.vertical,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
            }
        }
        .background(Color.lightGrayMore)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
        .toast(isPresenting: $sathaVM.toastShown) {
            AlertToast(displayMode: .hud, type: .error(Color.red), title: sathaVM.toastContent)
        }
        .toast(isPresenting: $sathaVM.toastShownInfo) {
            AlertToast(displayMode: .hud, type: .complete(Color.green), title: sathaVM.toastContentInfo)
        }
    }
}
