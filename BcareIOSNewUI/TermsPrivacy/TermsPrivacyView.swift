//
//  TermsPrivacyView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/27/24.
//

import Foundation
import SwiftUI
import WebKit

struct TermsPrivacyView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var webViewModel:WebViewModel? = nil
    var item:TermsPrivacyItem?
    @State var downloadUrl:URL?
    @State var showShareSheet = false
    init(item:TermsPrivacyItem){
        self.item = item
    }
    var body: some View {
        VStack {
            HStack {
                Button {
                } label: {
                    FAText(text: FontAwesome.backIcon,color: Color.black)
                        .onTapGesture {
//                            if let res = webViewModel,res.canGoBack {
//                                res.shouldGoBack = true
//                            }
//                            else {
                                presentationMode.wrappedValue.dismiss()
//                            }
                        }
                        .padding(.horizontal,20)
                }
                Spacer()
            }
            if let res = webViewModel {
                ZStack {
                    LoadingView()
                    WebViewContainer(webViewModel: res, downloadUrl: $downloadUrl)
                        .onChange(of:downloadUrl, perform: { newValue in
                            if let _ = newValue {
                                showShareSheet = true
                            }
                        })
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                }
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.white)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $showShareSheet) {
            if let res = downloadUrl {
                ShareSheet(activityItems: [res])
            }
        }
        .onAppear {
            if let res = item {
                webViewModel = WebViewModel(url: res.url)
            }
        }
    }
}
