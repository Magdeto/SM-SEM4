//
//  TutorialPopup.swift
//  MorseDecoder
//
//  Created by Magda Tsekova on 22/02/2025.
//

import SwiftUI

struct TutorialPopup: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                        .font(.headline)
                }
            }
            TabView{
                TutorialPage1()
                TutorialPage2()
                TutorialPage3()
                TutorialPage4()
            }

            .tabViewStyle(.page)

          
            }
        .padding()
    }
}

