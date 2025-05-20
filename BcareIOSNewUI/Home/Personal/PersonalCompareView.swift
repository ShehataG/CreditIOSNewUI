//
//  PersonalCompareView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import SVGKit


struct PersonalCompareView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var personalCompareVM = PersonalCompareVM()

    var body: some View {
        VStack {
            HStack {
                BackButton(color: Color.black)
                Spacer()
            }
            VStack(spacing:0) {
                let arr = personalCompareVM.dataDef
                List(arr.indices,id:\.self) { row in
                    CompareMainCell(item: arr[row],isLast: row == arr.count - 1)
                        .modifier(ListItemMode())
                }
                .modifier(ListMode())
            }
            .padding(.horizontal,20)
            Spacer()
        }
        .background(Color.lightGray3)
        .navigationBarBackButtonHidden()
//        .edgesIgnoringSafeArea(.top)
    }
}
