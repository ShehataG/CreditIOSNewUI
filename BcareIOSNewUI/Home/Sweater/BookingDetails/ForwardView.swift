//
//  ForwardView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/27/24.
//

import Foundation
import SwiftUI
import WebKit

struct ForwardView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State var webViewModel:WebViewModel? = nil
    var item:TermsPrivacyItem?
    @State var downloadUrl:URL?
    @State var showShareSheet = false
    @State var id = 0
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
                            coordinator.pop(2)
                        }
                }
                Spacer()
                Button {
                } label: {
                    FA6Text(text: FontAwesome6.syncIcon,color: Color.black)
                        .onTapGesture {
                            id += 1
                        }
                }
            }
            .padding(.horizontal,20)
            if let res = webViewModel {
                ZStack {
                    LoadingView()
                    WebViewContainer(webViewModel: res, downloadUrl: $downloadUrl)
                        .id(id)
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
