//
//  TutorialPage2.swift
//  MorseDecoder
//
//  Created by Magda Tsekova on 22/02/2025.
//

import SwiftUI

struct TutorialPage2: View {
    var body: some View {
        VStack {
            Image("dots2")
                .resizable() // Make the image resizable
                .scaledToFit() // Scale the image to fit the available space
                .frame(width: 200)
                .padding()
            
            Text("Press and hold the button to input Morse code.")
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
