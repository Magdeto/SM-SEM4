//
//  MorceDecoder.swift
//  MorseDecoder
//
//  Created by Magda Tsekova on 22/02/2025.
//
import Foundation

struct MorseDecoder {
    static func decode(_ morseSequence: String) -> String {
        let symbols = morseSequence.components(separatedBy: " ")
        var decodedText = ""
        
        for symbol in symbols {
            if let letter = MorseDictionary.morseCodeDict[symbol] {
                decodedText += letter
            } else {
                decodedText += "?"
            }
        }
        
        return decodedText
    }
}
