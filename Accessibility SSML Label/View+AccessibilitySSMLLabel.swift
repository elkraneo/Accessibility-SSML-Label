//
//  View+AccessibilitySSMLLabel.swift
//  Accessibility SSML Label
//
//  Created by Cristian Díaz on 23.05.24.
//

import AVFoundation
import SwiftUI

public struct SSML {
  public let rawValue: String

  init(_ representation: String) {
    self.rawValue = representation
  }
}

extension View {
  public func accessibilityLabel(_ ssml: SSML) -> some View {
    modifier(AccessibilitySSMLLabel(ssml: ssml))
  }
}

struct AccessibilitySSMLLabel: ViewModifier {
  @AccessibilityFocusState var isFocused: Bool
  let ssml: SSML
  let synthesizer: AVSpeechSynthesizer = {
    let synthesizer = AVSpeechSynthesizer()
    #if os(iOS)
      synthesizer.usesApplicationAudioSession = false
    #endif
    return synthesizer
  }()

  func body(content: Content) -> some View {
    content
      .accessibilityElement()
      .accessibilityFocused($isFocused)
      .onChange(of: isFocused) { _, newValue in
        if newValue,
          let utterance = AVSpeechUtterance(ssmlRepresentation: ssml.rawValue)
        {
          synthesizer.speak(utterance)
        } else {
          synthesizer.stopSpeaking(at: .word)
        }
      }
  }
}
