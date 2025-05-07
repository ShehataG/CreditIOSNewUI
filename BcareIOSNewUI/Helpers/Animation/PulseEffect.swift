//
//  PulseEffect.swift
//  BcareIOSNewUI
//
//  Created by Ahmed Mahmoud on 9/11/24.
//

import Foundation
import SwiftUI

struct PulseEffect: ViewModifier {
  @State private var pulseIsInMaxState: Bool = true
  private let range: ClosedRange<Double>
  private let duration: TimeInterval
  private let showAnimation:Bool

  init(range: ClosedRange<Double>, duration: TimeInterval, showAnimation: Bool) {
      self.range = range
      self.duration = duration
      self.showAnimation = showAnimation
  }

  func body(content: Content) -> some View {
      if showAnimation {
          content
              .opacity(pulseIsInMaxState ? range.upperBound : range.lowerBound)
              .onAppear { pulseIsInMaxState = false }
              .animation(.smooth(duration: duration).repeatForever(), value: pulseIsInMaxState)
      }
      else {
          content
      }
  }
}

public extension View {
  func pulseEffect(range: ClosedRange<Double> = 0.3...1, duration: TimeInterval = 0.5,showAnimation:Bool) -> some View  {
      modifier(PulseEffect(range: range, duration: duration,showAnimation:showAnimation))
  }
}
