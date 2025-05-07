////
////  Home.swift
////  BcareIOSNewUI
////
////  Created by Ahmed Mahmoud on 5/20/24.
////
//
//import Foundation
//import SwiftUI
//import WebKit
//
enum InsuranceType:Int {
    case vehicle = 0,medical,travel,malpractices
}
//
//struct CarStartView: View {
//    @EnvironmentObject var coordinator: Coordinator
//    let leftImages = ["carw","medicalw","travelw","malpracticesw"]
//    let gridRows:[GridItem] = [GridItem(.flexible())]
//    let imgWid:CGFloat = isIpad ? 70 : 50
//    let imgHighWid:CGFloat = isIpad ? 75 : 55
//    let listBackColor = Color(hex:"#EFF4FB")!
//    @State var gridHeight: CGFloat = 0
//    let item:InsuranceType
//    let info:InsuranceInfoItem
//    let gridHeightPercent:CGFloat = isIpad ? 0.4 : 0.6
//    init(item: InsuranceType) {
//        self.item = item
//        self.info = InsuranceStore.getData(item)
//    }
//    var body: some View {
//        VStack(spacing:0) {
//            VStack {
//                VStack {
//                    HStack(spacing:0) {
//                        Image(isAr ? "rightBackArrow" : "leftBackArrow")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: imgWid,height: imgWid)
//                            .onTapGesture {
//                                coordinator.pop()
//                            }
//                        Text(verbatim: info.header)
//                            .font(Fonts.tooSmallBold())
//                            .foregroundColor(Color.white)
//                            .padding(.horizontal,10)
//                        Spacer()
//                    }
//                    HStack {
//                        VStack(alignment: .leading,spacing:10) {
//                            Text(verbatim:info.title)
//                                .font(Fonts.mediumBold())
//                                .foregroundColor(Color.white)
//                            Text(verbatim:info.subtitle)
//                                .font(Fonts.verySmallLight())
//                                .foregroundColor(Color.white)
//                                .frame(width: screenWidth * 0.6, alignment: .leading)
//                                .padding(.horizontal,10)
//                                .multilineTextAlignment(.leading)
//                                .fixedSize(horizontal: true, vertical: false)
//                        }
//                        .frame(width: screenWidth * 0.6)
//                        Spacer()
//                        Image(leftImages[item.rawValue])
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: imgHighWid,height: imgHighWid)
//                    }
//                    .padding(.horizontal,20)
//                    .padding(.top,10)
//                }
//                .padding(.horizontal,10)
//                ZStack(alignment: .top) {
//                    let bottomItems = info.list
//                     VStack(spacing: 0) {
//                       List(bottomItems.indices,id: \.self) { row in
//                            CarListView(item: bottomItems[row])
//                               .modifier(ListItemMode())
//                        }
//                        .modifier(ListMode())
//                        .background(listBackColor)
//                        .padding(.top, screenWidth * gridHeightPercent * 0.6)
//                        RoundedLoaderBu(item: "BuyNow", textColor: .white, backEnableColor: appBlueColor,backDisableColor:appOrangeDarkColor , width: 0.8,vPadding: 20,showLoader:false)
//                             .padding(.top,20)
//                            .onTapGesture {
//                                let arr = [AppURL,MedicalURL,TravelURL,MalpracticesURL]
//                                coordinator.push(TermsPrivacyItem(url: createGl(arr[item.rawValue])))
//                            }
//                    }
//                    .padding(.horizontal,25)
//                    .padding(.bottom,40)
//                    .modifier(RoundedBackgroundModifer(color: listBackColor))
//                    .padding(.top, screenWidth * gridHeightPercent * 0.6)
//                    let filtered = info.grid
//                    ScrollViewReader { proxy in
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            LazyHGrid(rows:gridRows,alignment:.bottom,spacing: 10) {
//                                ForEach(filtered.indices,id: \.self) { row in
//                                    CarGridView(item: filtered[row])
//                                }
//                            }
//                        }
//                        .padding(.leading,30)
//                        .frame(height: screenWidth * 0.6)
//                        .padding(.vertical,20)
//                        .onFirstAppear {
//                            proxy.scrollTo(0)
//                        }
//                    }
//                }
//                .ignoresSafeArea(.all)
//            }
//            .frame(maxWidth: .infinity)
//            .background(appBlueColor)
//        }
//        .navigationBarBackButtonHidden()
//    }
//    func createGl(_ url:String) -> String {
//        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
//        var res = url + "?channel=ios&lang=\(langText)&version=\(version)&firebasetoken=\(FIREBASE_TOKEN ?? "")"
//        if let value = userBeginLoginItem , UserManager.isLoggedIn() {
//            print(value)
//            let data = try!JSONEncoder().encode(value)
//            res += "&gl=" + data.base64EncodedString()
//            print(res)
//            return res
//        }
//        else {
//            WKWebView.clean()
//            return res
//        }
//    }
//}
