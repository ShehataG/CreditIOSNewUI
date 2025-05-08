//
//  RiyalView.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 5/20/24.
//

import Foundation
import SwiftUI
import AxisTabView
  
struct CenterPreview: View {
    @State private var selection: Int = 0
    @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init())
    @State private var radius: CGFloat = 70
    @State private var concaveDepth: CGFloat = 0.85
    @State private var color: Color = .white
    var body: some View {
        GeometryReader { proxy in
            AxisTabView(selection: $selection, constant: constant) { state in
                CustomCenterStyle(state, color: color, radius: radius, depth: concaveDepth)
            } content: {
                ControlView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 0, systemName: "01.circle.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 1, systemName: "02.circle.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 2, systemName: "plus.circle.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 3, systemName: "04.circle.fill", safeArea: proxy.safeAreaInsets)
                ControlView(selection: $selection, constant: $constant, radius: $radius, concaveDepth: $concaveDepth, color: $color, tag: 4, systemName: "05.circle.fill", safeArea: proxy.safeAreaInsets)
            } onTapReceive: { selectionTap in
                /// Imperative syntax
                print("---------------------")
                print("Selection : ", selectionTap)
                print("Already selected : ", self.selection == selectionTap)
            }
        }
        .animation(.easeInOut, value: constant)
        .animation(.easeInOut, value: radius)
        .animation(.easeInOut, value: concaveDepth)
        .navigationTitle("Screen \(selection + 1)")
    }
}
 
public struct CustomCenterStyle: @preconcurrency ATBackgroundStyle {
    public var state: ATTabState
    public var color: Color = .white
    public var radius: CGFloat = 80
    public var depth: CGFloat = 0.8
    public init(_ state: ATTabState, color: Color, radius: CGFloat, depth: CGFloat) {
        self.state = state
        self.color = color
        self.radius = radius
        self.depth = depth
    }
    public var body: some View {
        let tabConstant = state.constant.tab
        GeometryReader { proxy in
            ATCurveShape(radius: radius, depth: depth, position: 0.5)
                .fill(color)
                .frame(height: tabConstant.normalSize.height + (state.constant.axisMode == .bottom ? state.safeAreaInsets.bottom : state.safeAreaInsets.top))
                .scaleEffect(CGSize(width: 1, height: state.constant.axisMode == .bottom ? 1 : -1))
                .mask(
                    Rectangle()
                        .frame(height: proxy.size.height + 100)
                )
                .shadow(color: tabConstant.shadow.color,
                        radius: tabConstant.shadow.radius,
                        x: tabConstant.shadow.x,
                        y: tabConstant.shadow.y)
        }
        .animation(.easeInOut, value: state.currentIndex)
    }
}
  
struct ControlView: View {
    @Binding var selection: Int
    @Binding var constant: ATConstant
    @Binding var radius: CGFloat
    @Binding var concaveDepth: CGFloat
    @Binding var color: Color
    let tag: Int
    let systemName: String
    let safeArea: EdgeInsets
    private var backgroundColor: Color {
        let colors = [Color(hex: 0x295A76), Color(hex: 0x7FACAA), Color(hex: 0xEBF4CC), Color(hex: 0xE79875), Color(hex: 0xBA523C), Color(hex: 0x295A76)]
        guard selection <= colors.count - 1 else { return Color(hex: 0x295A76)}
        return colors[selection].opacity(0.2)
    }
    private var content: some View {
        VStack(spacing: 20) {
        }
    }
    var body: some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor)
        }
        .tabItem(tag: tag, normal: {
            TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: false, systemName: systemName, title: "")
        }, select: {
            TabButton(constant: $constant, selection: $selection, tag: tag, isSelection: true, systemName: systemName, title: "")
        })
    }
}

public extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct TabButton: View {
    @Binding var constant: ATConstant
    @Binding var selection: Int
    let tag: Int
    let isSelection: Bool
    let systemName: String
    let title:String
    
    @State private var y: CGFloat = 0
    let imgWidth:CGFloat = isIpad ? 35 : 25

    var content: some View {
        VStack(alignment: .center,spacing: 0) {
            if systemName == "plus.circle.fill" {
//                Image(systemName: systemName)
//                    .resizable()
//                    .scaledToFit()
//                    .font(.system(size: 24))
//                    .padding(10)
//                    .frame(width: 65, height: 65)
                Text(verbatim: "ApplyNow".localized)
                    .font(Fonts.tooSmallBold())
                    .frame(width: 65, height: 65)
                    .foregroundStyle(Color.white)
                    .background(appGreenColor)
                    .clipShape(Circle())
                    .background(Circle().stroke(Color.white,lineWidth:4))
            }
            else {
                if isSelection {
                    Image(systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(appBlueColor)
                        .frame(width:imgWidth, height: imgWidth)
                    Text(verbatim: title.localized)
                        .foregroundStyle(appBlueColor)
                        .font(Fonts.tooSmallRegular())
                }
                else {
                    Image(systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.lightGray)
                        .frame(width:imgWidth, height: imgWidth)
                    Text(verbatim: title.localized)
                        .foregroundStyle(Color.lightGray)
                        .font(Fonts.tooSmallRegular())
                }
            }
        }
        .offset(y: positionY)
    }
    var body: some View {
        if constant.axisMode == .top {
            content
        } else {
            content
        }
    }
    private var positionY: CGFloat {
        if systemName == "plus.circle.fill" {
            return constant.axisMode == .bottom ? -20 : 20
        }
        return 0
    }
}
