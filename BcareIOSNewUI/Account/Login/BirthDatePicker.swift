//
//  BirthDatePicker.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import  SwiftUI

struct BirthDatePicker: View {
    @EnvironmentObject var coordinator: Coordinator
    @Environment(\.presentationMode) var presentationMode
    let title:String
    let isHigri:Bool
    var sentDate:Binding<String>
    let fromNow:Bool
    @State var temDob = ""
    @State var years = [String]()
    let imgArrowWid:CGFloat = isIpad ? 60.0 : 50.0
    @State private var selectedDate = Date()
    let dateRange: ClosedRange<Date> = {
       let calendar = Calendar.current
       let date = Date()
       let start = calendar.date(byAdding: .year, value: -100, to: date)!
       let end = date // calendar.date(byAdding: .year, value: -5, to: date)!
       return start...end
    }()
    
    init(title: String="BirthYear",isHigri:Bool,sentDate: Binding<String>,fromNow:Bool=false) {
        self.title = title
        self.isHigri = isHigri
        self.sentDate = sentDate
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
//                    Picker("", selection: $temDob) {
//                        ForEach(years,id:\.self) { item in
//                            Text(verbatim: item)
//                                .font(Fonts.smallBold())
//                                .tag(item)
//                        }
//                    }
//                    .pickerStyle(.wheel)
                    HStack {
                        Spacer()
                        DatePicker("", selection: $selectedDate,in:dateRange, displayedComponents: [.date])
                            .datePickerStyle(.wheel)
                        Spacer()
                    }
                    RoundedColoredBu(item: "Select".localized, width: 0.8)
                        .onTapGesture {
                            let formatter = DateFormatter()
                            formatter.locale = Locale(identifier: "en_US")
                            formatter.dateFormat = "dd-MM-yyyy"
                            sentDate.wrappedValue = formatter.string(from: selectedDate)
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                .colorScheme(.light)
                .padding(.bottom,30)
                .padding(20)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayMore))
                .onAppear {
//                    if isHigri {
//                        years = Array(1340...1435).map { "\($0)" }.reversed()
//                    }
//                    else {
//                        let top = fromNow ? Calendar(identifier: .gregorian).dateComponents([.year], from: Date()).year! : 2015
//                        years = Array(1920...top).map { "\($0)" }.reversed()
//                    }
//                    self.temDob = sentYear.wrappedValue == "" ? years.first! : sentYear.wrappedValue
                }
            }
        }
        .environment(\.layoutDirection, coordinator.layoutDirection)
        .edgesIgnoringSafeArea(.bottom)
    }
}
