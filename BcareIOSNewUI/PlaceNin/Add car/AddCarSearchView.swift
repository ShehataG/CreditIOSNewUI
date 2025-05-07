//
//  AddCarSearchView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
import MapKit
 
struct AddCarSearchView : View {
    @EnvironmentObject var coordinator: Coordinator
    @Binding var search:String
    let filtered:[String]
    var closeClicked:(()->())?
    var selectedClicked:((Int)->())?
    let imgArrowWid:CGFloat = isIpad ? 60.0 : 50.0
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
                               closeClicked?()
                            }
                   }
                   CarSearchlnputView(placeholder: "Search", value: $search, type: .search, topPadding: 10)
                   List(filtered.indices,id: \.self) { row in
                       VinSeachList(title: filtered[row], hasLine: row != filtered.count - 1)
                            .modifier(ListItemMode())
                            .onTapGesture {
                                selectedClicked?(row)
                            }
                   }
                   .modifier(ListMode())
                   .frame(height: screenHeight * 0.25)
                   .padding(.horizontal,20)
                   .padding(.vertical,10)
                   .background(Color.white)
                   .cornerRadius(10)
                   .padding(.top,5)
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
