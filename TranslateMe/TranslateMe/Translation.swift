//
//  Translation.swift
//  TranslateMe
//
//  Created by Nam Nguyen on 11/13/24.
//

import Foundation
import FirebaseFirestore

struct Translation: Identifiable, Codable {
    var id: String
    let sourceText: String
    let translatedText: String
    let fromLanguage: String
    let toLanguage: String
    let timestamp: Date
    
    init(id: String = UUID().uuidString,
         sourceText: String,
         translatedText: String,
         fromLanguage: String = "en",
         toLanguage: String = "es",
         timestamp: Date = Date()) {
        self.id = id
        self.sourceText = sourceText
        self.translatedText = translatedText
        self.fromLanguage = fromLanguage
        self.toLanguage = toLanguage
        self.timestamp = timestamp
    }
}
