//
//  TranslationService.swift
//  TranslateMe
//
//  Created by Nam Nguyen on 11/13/24.
//

import Foundation

class TranslationService {
    private let baseURL = "https://api.mymemory.translated.net/get"
    
    func translate(text: String, from: String = "en", to: String = "es") async throws -> String {
        let urlString = "\(baseURL)?q=\(text)&langpair=\(from)|\(to)"
        
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(TranslationResponse.self, from: data)
        
        return response.responseData.translatedText
    }
}

// Response models
struct TranslationResponse: Codable {
    let responseData: ResponseData
    
    struct ResponseData: Codable {
        let translatedText: String
    }
}
