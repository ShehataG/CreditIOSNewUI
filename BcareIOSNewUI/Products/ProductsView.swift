//
//  ProductsView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI


struct ProductsView: View {
    @EnvironmentObject var coordinator: Coordinator
    let gridRows:[GridItem] = [GridItem(.flexible())]
    let imgMainWid:CGFloat = isIpad ? 120.0 : 100.0
    let gridColumns = [GridItem(.adaptive(minimum: (screenWidth * 0.7 - 10) * 0.5))]
    @State var id:Int?
    @State var showBack = false
    let imgArrowWid:CGFloat = isIpad ? 50.0 : 40.0
    let imgWid:CGFloat = isIpad ? 40 : 30
    let itemWidth = (screenWidth * 0.7 - 21) * 0.5
    let productsItems = [
        ProductsItem(backImage: "vehicleinsurance", title: "Vehicle".localized),
        ProductsItem(backImage: "medicalinsurance",title: "Medical".localized),
        ProductsItem(backImage: "travelinsurance",title: "Travel".localized),
        ProductsItem(backImage: "malprainsurance",title: "Malpractices".localized)
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
           BackPlaceholderView(factor: 0.5)
           ScrollView(showsIndicators: false) {
            SharedHeaderView()
                VStack(spacing:0) {
                    LineDotView(title:"Products") 
                    ScrollView {
                        LazyVGrid(columns: gridColumns,spacing: 10) {
                            ForEach(productsItems.indices,id: \.self) { row in
                                ProductsGridView(item: productsItems[row])
                                    .onTapGesture {
                                       coordinator.push(TermsPrivacyItem(url: createGl(InsuranceType(rawValue: row)!)))
                                    }
                            }
                        }
                        .frame(width: screenWidth * 0.7)
                    }
                }
                .padding(.top,10)
                .modifier(RoundedBackgroundModifer(color: Color.lightGrayCommon))
            }
            //.scrollIndicators(.never)
        }
//        .tabItem(tag: tag, normal: {
//            TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: false, systemName: systemName, title: "Calculator")
//        }, select: {
//            TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: true, systemName: systemName, title: "Calculator")
//        })
        .background(Color.lightGrayCommon)
    }
}
