//
//  PageView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 7/11/24.
//

import Foundation
import SwiftUI

struct PageView<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    @Binding private var selection: SelectionValue
    private let indexDisplayMode: PageTabViewStyle.IndexDisplayMode
    private let indexBackgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode
    private let content: () -> Content

    init(
        selection: Binding<SelectionValue>,
        indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .never,
        indexBackgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode = .never,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selection = selection
        self.indexDisplayMode = indexDisplayMode
        self.indexBackgroundDisplayMode = indexBackgroundDisplayMode
        self.content = content
    }

    var body: some View {
        TabView(selection: $selection) {
            content()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: indexDisplayMode))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: indexBackgroundDisplayMode))
    }
}

extension PageView where SelectionValue == Int {
    init(
        indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .automatic,
        indexBackgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode = .never,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selection = .constant(0)
        self.indexDisplayMode = indexDisplayMode
        self.indexBackgroundDisplayMode = indexBackgroundDisplayMode
        self.content = content
    }
}
