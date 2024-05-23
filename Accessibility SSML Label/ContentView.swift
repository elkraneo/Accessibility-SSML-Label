//
//  ContentView.swift
//  Accessibility SSML Label
//
//  Created by Cristian Díaz on 22.05.24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)

      Text("Hello, world!")
        .accessibilityLabel(
          SSML(
            """
            <speak>
              <prosody pitch="high">
                <lang xml:lang="fr-FR">Bonjour!</lang>
              </prosody>
              After one second, I'm going to speak more slowly.
              <break time="1s"/>
              <prosody rate="x-slow">
                Slow speech using <say-as interpret-as="verbatim">SSML</say-as>...
              </prosody>
            </speak>
            """
          )
        )
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
