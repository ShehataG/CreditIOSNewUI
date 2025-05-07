//
//  SplashPermissionsView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//


import Foundation
import SwiftUI
import SwiftUIPager

struct SplashPermissionsView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State var page: Page = .first()
    var body: some View {
        VStack {
            Pager(page: page,
                  data: Array(0...1),
                  id: \.self) { row in
                if row == 0 {
                    LocationAllowView(page:$page)
                        .tag(row)
                }
                else {
                    NotificationAllowView()
                        .tag(row)
                }
            }
              .itemSpacing(10)
              .horizontal(.startToEnd)
              .interactive(scale: 1.0)
              .disableDragging()
              .frame(maxWidth: .infinity)
         }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.white)
        .navigationBarBackButtonHidden()
    }
}
