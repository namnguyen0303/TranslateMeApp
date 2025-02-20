//
//  SavedTranslationsView.swift
//  TranslateMe
//
//  Created by Nam Nguyen on 11/13/24.
//

import SwiftUI

struct SavedTranslationsView: View {
    @Environment(TranslationManager.self) var translationManager
    
    var body: some View {
        List {
            ForEach(translationManager.translations) { translation in
                VStack(alignment: .leading, spacing: 8) {
                    Text(translation.sourceText)
                        .font(.headline)
                    Text(translation.translatedText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Saved Translations")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Clear All") {
                    Task {
                        try? await translationManager.clearHistory()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SavedTranslationsView()
            .environment(TranslationManager())
    }
}
