//
//  TranslateManager.swift
//  TranslateMe
//
//  Created by Nam Nguyen on 11/13/24.
//

import Foundation
import FirebaseFirestore

@Observable
class TranslationManager {
    var translations: [Translation] = []
    private let database = Firestore.firestore()
    private let translationService = TranslationService()
    
    init(isMocked: Bool = false) {
        if !isMocked {
            setupTranslationsListener()  // Changed to use a separate setup method
        }
    }
    
    func translate(text: String, from: String, to: String) async throws {
        // Get translation from API
        let translatedText = try await translationService.translate(text: text, from: from, to: to)
        
        // Create translation object
        let translation = Translation(
            sourceText: text,
            translatedText: translatedText,
            fromLanguage: from,
            toLanguage: to
        )
        
        // Save to Firebase
        try await saveTranslation(translation)
    }
    
    func saveTranslation(_ translation: Translation) async throws {
        try await database.collection("translations")
            .document(translation.id)
            .setData(from: translation)
    }
    
    private func setupTranslationsListener() {
        database.collection("translations")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching translations: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                self?.translations = documents.compactMap { document in
                    try? document.data(as: Translation.self)
                }
            }
    }
    
    func clearHistory() async throws {  // Made async
        let snapshot = try await database.collection("translations").getDocuments()
        let batch = database.batch()
        
        // Delete each document
        snapshot.documents.forEach { document in
            batch.deleteDocument(document.reference)
        }
        
        // Commit the batch
        try await batch.commit()
        self.translations.removeAll()
    }
}
