//
//  WelcomeView.swift
//  MorseDecoder
//
//  Created by Magda Tsekova on 22/02/2025.
//

import SwiftUI
struct WelcomeView: View {
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Welcome to Magda's Morse Decoder!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .multilineTextAlignment(.center)
                
                NavigationLink(destination: HomeView()) {
                    Text("Start decoding")
                        .frame(maxWidth: .infinity) // Take full width
                        .padding(.vertical) // Add vertical padding
                        .background(Color.black)
                        .foregroundStyle(.white)
                        .cornerRadius(24)
                }
                .padding(.horizontal)
            }
        
        }
    }
}
#Preview {
    WelcomeView()
}
