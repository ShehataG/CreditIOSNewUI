//
//  ListView.swift
//  BcareIOSNewUI
//
//  Created by MacBook Pro on 30/05/2024.
//

import Foundation
import SwiftUI

struct ListMode: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(.plain)
            .frame(maxWidth: .infinity)
            .modifier(HideScrollIndicator())
            .modifier(HideListSectionSeparator())
    }
}

struct ListItemMode: ViewModifier {
    func body(content: Content) -> some View {
        content
             .modifier(ListRowSeparatorTint())
             .listRowBackground(Color.clear)
             .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct HideScrollIndicator: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollIndicators(.never)
        } else {
            content
        }
    }
}
 
struct HideListSectionSeparator: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .listSectionSeparator(.hidden)
        } else {
            content
        }
    }
}

struct ListRowSeparatorTint: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
              .listRowSeparatorTint(.clear)
        } else {
            content
        }
    }
}
