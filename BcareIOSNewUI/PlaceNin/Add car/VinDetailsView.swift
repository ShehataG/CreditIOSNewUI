//
//  VinDetailsView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
import MapKit
 
struct VinDetailsView : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coordinator: Coordinator
    let imgArrowWid:CGFloat = isIpad ? 60.0 : 50.0
    let steps = (1...3).map { "CarFindWay\($0)" }
    let gridRows:[GridItem] = [GridItem(.flexible())]
    var body: some View {
        ZStack {
           PlaceholderView()
           VStack {
               Spacer()
               VStack {
                   HStack  {
                       Spacer()
                       Image("closebacked")
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           .frame(width: imgArrowWid,height: imgArrowWid)
                           .onTapGesture {
                               presentationMode.wrappedValue.dismiss()
                            }
                   }
                   HStack {
                       Text(verbatim: "Vin".localized)
                           .font(Fonts.smallRegular())
                           .foregroundColor(.black)
                           .padding(.top,20)
                       Spacer()
                   }
                   HStack {
                       Text(verbatim: "CanFindVin".localized)
                           .font(Fonts.verySmallLight())
                           .foregroundColor(Color.sevenLightGray)
                           .padding(.top,5)
                       Spacer()
                   }
                   .frame(maxWidth: .infinity)
                   VStack(spacing: 0) {
                       ForEach(steps.indices,id: \.self) { row in
                           HStack {
                               Text(verbatim: "\(row + 1) - " + steps[row].localized)
                                   .font(Fonts.tooSmallLight())
                                   .foregroundColor(Color.sevenLightGray)
                                   .padding(.vertical,3)
                               Spacer()
                           }
                       }
                   }
                   .padding(.top,5)
               }
               .padding(.bottom,60)
               .padding(20)
               .modifier(RoundedBackgroundModifer(color: .white))
           }
       }
       .environment(\.layoutDirection, coordinator.layoutDirection)
       .edgesIgnoringSafeArea(.bottom)
    }
}
