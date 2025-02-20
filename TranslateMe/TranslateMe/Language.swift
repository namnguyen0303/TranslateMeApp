//
//  Language.swift
//  TranslateMe
//
//  Created by Nam Nguyen on 11/13/24.
//

import Foundation

struct Language: Identifiable, Hashable {
    let id = UUID()
    let code: String      // e.g., "en", "es", "fr"
    let name: String      // e.g., "English", "Spanish", "French"
    
    static let languages = [
        Language(code: "en", name: "English"),
        Language(code: "es", name: "Spanish"),
        Language(code: "fr", name: "French"),
        Language(code: "de", name: "German"),
        Language(code: "it", name: "Italian"),
        Language(code: "pt", name: "Portuguese"),
        Language(code: "ru", name: "Russian"),
        Language(code: "ja", name: "Japanese"),
        Language(code: "ko", name: "Korean"),
        Language(code: "zh", name: "Chinese"),
        
    ]
}
