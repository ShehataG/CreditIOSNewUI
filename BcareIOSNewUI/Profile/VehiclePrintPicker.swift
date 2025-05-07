//
//  VehiclePrintPicker.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/22/24.
//

import Foundation
import  SwiftUI

struct VehiclePrintPicker: View {
    @Environment(\.presentationMode) var presentationMode
    let vehicles:[String]
    var selected:Binding<String>
    var selectedVehicle:Binding<Int>
    init(vehicles: [String],selected: Binding<String>, selecVehicle: Binding<Int>) {
        self.vehicles = vehicles
        self.selected = selected
        self.selectedVehicle = selecVehicle
    }
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
                            Text(verbatim: FontAwesome.closeIcon)
                                .font(Fonts.fontAwesome30_40())
                                .foregroundColor(appBlueColor)
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                .padding(.horizontal,20)
                                .padding(.top,5)
                        }
                    }
                    Text(verbatim: "ChooseVehicle".localized)
                        .font(Fonts.mediumRegular())
                        .padding(5)
                    Picker("", selection: selectedVehicle) {
                        ForEach(vehicles.indices,id:\.self) { row in
                            Text(verbatim: vehicles[row])
                                .font(Fonts.smallBold())
                                .tag(row)
                        }
                    }
                    .pickerStyle(.wheel)
                    HStack {
                        RoundedColoredBu(item: "PrintPolicy".localized, width: 0.8,color: appOrangeColor)
                            .onTapGesture {
                                selected.wrappedValue = vehicles[selectedVehicle.wrappedValue]
                                presentationMode.wrappedValue.dismiss()
                            }
                        RoundedColoredBu(item: "PrintBill".localized, width: 0.8,color: appOrangeColor)
                            .onTapGesture {
                                selected.wrappedValue = vehicles[selectedVehicle.wrappedValue]
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
                .colorScheme(.light)
                .background(Color.white)
            }
        }
    }
}
