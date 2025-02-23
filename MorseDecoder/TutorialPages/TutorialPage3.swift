//
//  TutorialPage3.swift
//  MorseDecoder
//
//  Created by Magda Tsekova on 22/02/2025.
//
import SwiftUI

struct TutorialPage3: View {
    var body: some View {
        VStack {
            Image("dots3")
                .resizable() // Make the image resizable
                .scaledToFit() // Scale the image to fit the available space
                .frame(width: 200)
                .padding()
            Text("Short press (less than 0.3s) = Dot (·)")
            Text("Long press (more than 0.3s) = Dash (–)")
                .multilineTextAlignment(.center)
        }
    }
}
