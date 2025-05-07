//
//  YearPicker.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import  SwiftUI

struct YearPicker: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.presentationMode) var presentationMode
    let title:String
    let isHigri:Bool
    var sentYear:Binding<String>
    let fromNow:Bool
    @State var temDob = ""
    @State var years = [String]()
    let imgArrowWid:CGFloat = isIpad ? 60.0 : 50.0
    init(title: String="BirthYear",isHigri:Bool,sentYear: Binding<String>,fromNow:Bool=false) {
        self.title = title
        self.isHigri = isHigri
        self.sentYear = sentYear
        self.fromNow = fromNow
    }
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
                    Text(verbatim: title.localized)
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
                            sentYear.wrappedValue = temDob
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                .colorScheme(.light)
                .padding(.bottom,30)
                .padding(20)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
                .onAppear {
                    if isHigri {
                        years = Array(1340...1435).map { "\($0)" }.reversed()
                    }
                    else {
                        let top = fromNow ? Calendar(identifier: .gregorian).dateComponents([.year], from: Date()).year! : 2015
                        years = Array(1920...top).map { "\($0)" }.reversed()
                    }
                    self.temDob = sentYear.wrappedValue == "" ? years.first! : sentYear.wrappedValue
                }
            }
        }
        .environment(\.layoutDirection, coordinator.layoutDirection)
        .edgesIgnoringSafeArea(.bottom)
    }
}
