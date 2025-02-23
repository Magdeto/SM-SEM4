
## Morse Decoder App
### Overview

The Morse Decoder app is a simple iOS application that allows users to input Morse code using a button and translates it into plain text. The app is built using SwiftUI and is designed to be user-friendly and accessible.

### Features

Morse Input: Users can input Morse code using a button (short press for dot, long press for dash).
Real-Time Decoding: The app decodes Morse code into plain text in real-time.
Tutorial: A tutorial popup explains how to use the app.

## Project Structure
MorseDecoder/
├── Screens/
│   ├── WelcomeView.swift          // Welcome screen with a "Start decoding" button
│   ├── HomeView.swift             // Main screen with Morse decoding functionality
├── Components/
│   ├── MorseButton.swift          // Reusable Morse input button
│   ├── TutorialPopup.swift        // Popup for the tutorial
├── Utilities/
│   ├── MorseDecoder.swift         // Morse decoding logic
│   ├── MorseDictionary.swift      // Morse code dictionary
├── Assets.xcassets/               // Contains images and icons
├── MorseDecoderApp.swift          // App entry point

## Getting Started

### Prerequisites

Xcode: Ensure you have Xcode installed (version 13 or later recommended).
iOS Device or Simulator: To run the app, you’ll need an iPhone or iPad (physical device or simulator).
Installation

Clone the repository:
bash
Copy
git clone https://github.com/your-username/your-repo-name.git

open MorseDecoder.xcodeproj
Select your target device or simulator in Xcode.
Click the Run button (▶) to build and run the app.
