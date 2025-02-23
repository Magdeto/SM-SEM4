//
//  ContentView.swift
//  MorseDecoder
//
//  Created by Magda Tsekova on 20/02/2025.
//

import SwiftUI

struct HomeView: View {
    // MARK: - State Variables
    @State private var decodedText = ""
    @State private var currentMorse = ""
    @State private var currentLetter = ""
    @State private var lastReleaseTime = Date()
    @State private var isFirstPress = true
    @State private var showTutorial = true
    
    // MARK: - Constants
    let letterSpace: TimeInterval = 1.5
    let wordSpace: TimeInterval = 2.5
    
    // MARK: - UI
    var body: some View {
        NavigationView {
            VStack {
                // Top corner menu
                HStack {
                    Spacer()
                    Button(action: {
                        showTutorial = true // Show tutorial
                    }) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.title)
                            .padding()
                            .foregroundStyle(.black)
                    }
                }
                
                // Decoded Text and Current Morse
                VStack(alignment: .leading, spacing: 20) {
                    Text("Decoded Text:")
                        .font(.headline)
                    TextField("Decoded Text", text: $decodedText)
                        .font(.title)
                        .padding()
                        .disabled(true)
                    
                    Text("Current Morse:")
                        .font(.headline)
                    TextField("Current Morse", text: $currentMorse)
                        .font(.title)
                        .padding()
                        .disabled(true)
                }
                .padding()
                
                Spacer()
                
                // Morse Input Button
                MorseButton { symbol in
                    handleSymbolInput(symbol)
                }
                .padding(.bottom, 20)
                Button(action: {
                                      clearText()
                                  }) {
                                      Image(systemName: "trash.fill")
                                          .font(.title)
                                          .foregroundColor(.red)
                                          .padding()
                                  }
                
            }
            .sheet(isPresented: $showTutorial) {
                TutorialPopup() // Show tutorial as a sheet
            }
        }
    }
    
    
    private func handleSymbolInput(_ symbol: String) {
        let now = Date()
        let timeSinceLastRelease = now.timeIntervalSince(lastReleaseTime)
        
        // Handle spacing for non-first presses
        if !isFirstPress {
            if timeSinceLastRelease > wordSpace {
                decodeCurrentLetter()
                currentMorse += " / "
                decodedText += " "
            } else if timeSinceLastRelease > letterSpace {
                decodeCurrentLetter()
                currentMorse += " "
            }
        } else {
            isFirstPress = false
        }
        
        // Add the new symbol
        currentLetter += symbol
        currentMorse += symbol
        lastReleaseTime = now
        
        // Decode the Morse sequence
        decodedText = MorseDecoder.decode(currentMorse)
        
        // Debug logs
        print("Current Morse Sequence: \(currentMorse)")
    }
    
    /// Decodes the current Morse letter and resets it
    private func decodeCurrentLetter() {
        if !currentLetter.isEmpty {
            if let letter = MorseDictionary.morseCodeDict[currentLetter] {
                decodedText += letter
            } else {
                decodedText += "?"
            }
            currentLetter = ""
        }
    }
    /// Clears the current Morse and decoded text
    private func clearText() {
        currentMorse = ""
        decodedText = ""
        currentLetter = ""
        isFirstPress = true
    }
}
#Preview {
    HomeView()
}
