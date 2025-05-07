//
//  BirthMonthPicker.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import  SwiftUI

struct BirthMonthPicker: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.presentationMode) var presentationMode
    let isHigri:Bool
    var birthMonth:Binding<String>
    var birthMonthIdex:Binding<Int>
    @State var temDob = ""
    @State var years = [String]()
    let imgArrowWid:CGFloat = isIpad ? 60.0 : 50.0
    var body: some View {
        ZStack {
            PlaceholderView()
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Button {
                        } label: {
                            Image("closebacked")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: imgArrowWid,height: imgArrowWid)
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()
                                }
                        }
                    }
                    Text(verbatim: "BirthMonth".localized)
                        .font(Fonts.mediumRegular())
                        .padding(5)
                    Picker("", selection: $temDob) {
                        ForEach(years,id:\.self) { item in
                            Text(verbatim: item)
                                .font(Fonts.smallBold())
                                .tag(item)
                        }
                    }
                    .pickerStyle(.wheel)
                    RoundedColoredBu(item: "Select".localized, width: 0.8)
                        .onTapGesture {
                            birthMonth.wrappedValue = temDob
                            birthMonthIdex.wrappedValue = years.firstIndex(of: temDob)! + 1
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                .colorScheme(.light)
                .padding(.bottom,30)
                .padding(20)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
                .onAppear {
                    if isHigri {
                        years = Array(1...12).map { "HMonthList\($0)".localized }
                    }
                    else {
                        years = Array(1...12).map { "GMonthList\($0)".localized }
                    }
                    self.temDob = birthMonth.wrappedValue == "" ? years.first! : birthMonth.wrappedValue
                }
            }
        }
        .environment(\.layoutDirection, coordinator.layoutDirection)
        .edgesIgnoringSafeArea(.bottom)
    } 
}
