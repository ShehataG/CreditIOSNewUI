//
//  ViewExtensions.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 6/3/24.
//

import Foundation
import SwiftUI
import Combine

extension View {
    func onReceive(
        _ name: Notification.Name,
        center: NotificationCenter = .default,
        object: AnyObject? = nil,
        perform action: @escaping (Notification) -> Void
    ) -> some View {
        onReceive(
            center.publisher(for: name, object: object),
            perform: action
        )
    }
    func onSwipe(perform action: ((UISwipeGestureRecognizer.Direction) -> Void)? = nil) -> some View {
        return self.modifier(SwipeModifier(perform: action))
    }
}

struct SwipeModifier: ViewModifier {
    let action: ((UISwipeGestureRecognizer.Direction) -> Void)?

    init(perform action: ((UISwipeGestureRecognizer.Direction) -> Void)? = nil) {
        self.action = action
    }
        
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture(minimumDistance: 24.0, coordinateSpace: .local)
                .onEnded { value in
                    guard let action = action else {
                        return
                    }
                    if value.startLocation.x > value.location.x {
                        action(.left)
                    } else if value.startLocation.x < value.location.x {
                        action(.right)
                    } else if value.startLocation.y > value.location.y {
                        action(.down)
                    } else if value.startLocation.y < value.location.y {
                        action(.up)
                    }
                })
    }
}
  
struct SizeCalculator: ViewModifier {
    @Binding var size: CGSize
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            size = proxy.size
                        }
                }
            )
    }
}

struct RotateModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaleEffect(x: isAr ? 1  : -1, y: 1)
    }
}

extension View {
    func saveSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}
 
struct MultiLine: ViewModifier {
    let alignment:TextAlignment
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(alignment)
            .fixedSize(horizontal: false, vertical: true)
    }
}

fileprivate struct ModifierCornerRadiusWithBorder: ViewModifier {
    var radius: CGFloat
    var borderLineWidth: CGFloat = 1
    var borderColor: Color = .gray
    var antialiased: Bool = true
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(self.radius, antialiased: self.antialiased)
            .overlay(
                RoundedRectangle(cornerRadius: self.radius)
                    .strokeBorder(self.borderColor, lineWidth: self.borderLineWidth, antialiased: self.antialiased)
            )
    }
}

extension View {
    func cornerRadiusWithBorder(radius: CGFloat, borderLineWidth: CGFloat = 1, borderColor: Color = .gray, antialiased: Bool = true) -> some View {
        modifier(ModifierCornerRadiusWithBorder(radius: radius, borderLineWidth: borderLineWidth, borderColor: borderColor, antialiased: antialiased))
    }
}

extension View {
  func enableBounces() -> some View {
    modifier(EnableBouncesModifier())
  }
}

struct EnableBouncesModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .onAppear {
        UIScrollView.appearance().bounces = true
      }
      .onDisappear {
        UIScrollView.appearance().bounces = false
      }
  }
}

public extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(ViewFirstAppearModifier(perform: action))
    }
}

struct ViewFirstAppearModifier: ViewModifier {
    @State private var didAppearBefore = false
    private let action: () -> Void
    
    init(perform action: @escaping () -> Void) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.onAppear {
            guard !didAppearBefore else { return }
            didAppearBefore = true
            action()
        }
    }
}

struct PresentationBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            content.presentationBackground(.clear)
        } else {
            content.background(TransparentBackground())
        }
    }
}
struct TransparentBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

//@available(iOS 15.0, *)
//private struct TextFieldFocused<Value>: ViewModifier where Value: Hashable {
//    private let value: Value
//    @FocusState private var focused: Value?
//    @Binding private var binding: Value?
//
//    init(binding: Binding<Value?>, value: Value) {
//        self._binding = binding
//        self.value = value
//    }
//
//    func body(content: Content) -> some View {
//        content
//            .focused($focused, equals: value)
//            .onChange(of: binding) { newValue in
//                focused = newValue
//            }
//            .onChange(of: focused) { newValue in
//                if newValue != nil {
//                    binding = newValue
//                }
//            }
//            .onAppear {
//                focused = binding
//            }
//    }
//}
//
//extension View {
//    @ViewBuilder
//    func focused<Value>(_ binding: Binding<Value?>, equals value: Value) -> some View where Value: Hashable {
//        if #available(iOS 15.0, *) {
//            self.modifier(TextFieldFocused(binding: binding, value: value))
//        } else {
//            self
//        }
//    }
//}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
 
struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
