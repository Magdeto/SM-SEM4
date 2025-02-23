//
//  TutorialPage1.swift
//  MorseDecoder
//
//  Created by Magda Tsekova on 22/02/2025.
//

import SwiftUI

struct TutorialPage1: View {
    var body: some View {
        VStack {
            Image("dots")
                .resizable() // Make the image resizable
                .scaledToFit() // Scale the image to fit the available space
                .frame(width: 200)
                .padding()
            Text("Welcome to Magda's Morse Decoder")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("This app helps you decode Morse code into plain text.")
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
#Preview {
    TutorialPage1()
}
