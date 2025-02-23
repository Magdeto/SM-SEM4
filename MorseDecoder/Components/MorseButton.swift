//
//  MorseButton.swift
//  MorseDecoder
//
//  Created by Magda Tsekova on 20/02/2025.
//

import SwiftUI

struct MorseButton: View {
    var onInput: (String) -> Void
    
    @State private var isPressed = false
    @State private var pressStartTime = Date()
    
    let dotDuration = 0.3
    
    var body: some View {
        Button(action: {}) {
            Text(isPressed ? "Release to End" : "Press to Start")
                .padding()
                .frame(maxWidth: .infinity) // Take all available width
                .background(isPressed ? Color.gray : Color.black)
                .foregroundStyle(isPressed ? Color.black : Color.white)
                .font(.headline)
                .cornerRadius(20)
            
        }
        .padding(.horizontal, 20)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in handlePressStart()}
                .onEnded { _ in handlePressEnd()}
                )
        }
    private func handlePressStart() {
        isPressed = true
        pressStartTime = Date()
    }
    private func handlePressEnd() {
        isPressed = false
        let duration = Date().timeIntervalSince(pressStartTime)
        let symbol = duration < dotDuration ? "." : "-"
        
        
        print("Button released after \(duration) seconds")
        print("Detected symbol: \(symbol)")
        
        onInput(symbol)
    }
}
