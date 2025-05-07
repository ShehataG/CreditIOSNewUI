//
//  MedicalMenuView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 25/05/2024.
//

import Foundation
import SwiftUI
import Combine
import MapKit
struct MedicalMenuItem {
    let name,place:String
}
struct MedicalMenuView: View {
    @State var selected = 0
    let imgWidth:CGFloat = isIpad ? 30.0 : 20.0
    let items = [
        MedicalMenuItem(name: "مستشفى الملك سلمان", place: "الرياض"),
        MedicalMenuItem(name: "مستشفى الإيمان العام", place: "الرياض"),
        MedicalMenuItem(name: "مجمع د. فهد بافقيه الطبي", place: "الرياض"),
        MedicalMenuItem(name: "مستشفى سدك الطبية", place: "الرياض"),
        MedicalMenuItem(name: "مجمع بدرة الطبي", place: "الرياض"),
        MedicalMenuItem(name: "مستشفى الملك سلمان", place: "الرياض"),
        MedicalMenuItem(name: "مستشفى الإيمان العام", place: "الرياض"),
        MedicalMenuItem(name: "مجمع د. فهد بافقيه الطبي", place: "الرياض"),
        MedicalMenuItem(name: "مستشفى سدك الطبية", place: "الرياض"),
        MedicalMenuItem(name: "مجمع بدرة الطبي", place: "الرياض"),
        MedicalMenuItem(name: "مستشفى الملك سلمان", place: "الرياض"),
        MedicalMenuItem(name: "مستشفى الإيمان العام", place: "الرياض"),
        MedicalMenuItem(name: "مجمع د. فهد بافقيه الطبي", place: "الرياض"),
        MedicalMenuItem(name: "مستشفى سدك الطبية", place: "الرياض"),
        MedicalMenuItem(name: "مجمع بدرة الطبي", place: "الرياض"),
        MedicalMenuItem(name: "مستشفى الملك سلمان", place: "الرياض"),
        MedicalMenuItem(name: "مستشفى الإيمان العام", place: "الرياض"),
        MedicalMenuItem(name: "مجمع د. فهد بافقيه الطبي", place: "الرياض"),
        MedicalMenuItem(name: "مستشفى سدك الطبية", place: "الرياض"),
        MedicalMenuItem(name: "مجمع بدرة الطبي", place: "الرياض")
    ]
    var body: some View {
        ZStack(alignment: .top) {
            BackPlaceholderView(factor: 0.3)
            VStack {
                HStack {
                    BackButton()
                    Spacer()
                    Text(verbatim:"ShowList".localized)
                        .font(Fonts.mediumRegular())
                        .foregroundColor(Color.white)
                        .padding(.horizontal,10)
                        .padding(.bottom,15)
                }
                .padding(.horizontal,10)
                VStack {
                    List(items.indices,id: \.self) { row in
                        MedicalMenuList(item: items[row],backColor: row % 2 == 0 ? Color.white : Color.clear)
                            .modifier(ListItemMode())
                     }
                     .modifier(ListMode())
                }
                .padding(.top,60)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .modifier(RoundedBackgroundModifer(color: Color(hex: "#F2F4F6")!))
                Spacer()
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.bottom)
    }
}
