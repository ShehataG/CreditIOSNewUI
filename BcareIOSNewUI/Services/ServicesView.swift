//
//  ServicesView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
  
struct ServicesView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State var id:Int?
    
    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.4)
            ScrollView(showsIndicators: false) {
                SharedHeaderView()
                VStack(spacing:0) {
                    LineDotView(title:"Services")
                    VehMedGeneralView()
                     .padding(.leading,30)
                }
                .padding(.top,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayCommon))
            }
            //.scrollIndicators(.never) 
        }
        .background(Color.lightGrayCommon)
    }
}
