//
//  ProvidersOptionsImageBu.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 20/05/2024.
//

import Foundation
import SwiftUI

struct ProvidersOptionsImageBu: View {
    let normalImg:String
    let selectedImg:String
    let isSelected:Bool
    let imgHeight:CGFloat = isIpad ? 30.0 : 20.0
    var body: some View {
        if isSelected {
            HStack {
                Image(selectedImg)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imgHeight * 47 / 21,height: imgHeight)
                    .padding(.horizontal,5)
            }
            .padding(.vertical,10)
            .padding(.horizontal,5)
            .background(appBlueColor)
            .cornerRadius(10)
        }
        else {
            HStack {
                Image(normalImg)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imgHeight * 47 / 21,height: imgHeight)
                    .padding(.horizontal,5)
            }
            .padding(.vertical,10)
            .padding(.horizontal,5)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}
