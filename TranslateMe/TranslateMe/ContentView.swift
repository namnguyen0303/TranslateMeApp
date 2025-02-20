//
//  ContentView.swift
//  TranslateMe
//
//  Created by Nam Nguyen on 11/13/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(TranslationManager.self) var translationManager
    @State private var inputText: String = ""
    @State private var isTranslating = false
    @State private var fromLanguage = Language.languages[0]
    @State private var toLanguage = Language.languages[1]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Title with blue gradient
                Text("TranslateMe")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .padding(.top, 20)
                
                // Language Selection
                HStack(spacing: 15) {
                    // From Language
                    Menu {
                        Picker("From", selection: $fromLanguage) {
                            ForEach(Language.languages) { language in
                                Text(language.name).tag(language)
                            }
                        }
                    } label: {
                        HStack {
                            Text(fromLanguage.name)
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                        .padding(8)
                        .frame(width: 130)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    
                    // Swap Button
                    Button {
                        let temp = fromLanguage
                        fromLanguage = toLanguage
                        toLanguage = temp
                    } label: {
                        Image(systemName: "arrow.left.arrow.right")
                            .foregroundStyle(.blue)
                            .padding(8)
                            .background(.blue.opacity(0.1))
                            .clipShape(Circle())
                    }
                    
                    // To Language
                    Menu {
                        Picker("To", selection: $toLanguage) {
                            ForEach(Language.languages) { language in
                                Text(language.name).tag(language)
                            }
                        }
                    } label: {
                        HStack {
                            Text(toLanguage.name)
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                        .padding(8)
                        .frame(width: 130)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                // Input Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Enter Text")
                        .foregroundStyle(.secondary)
                        .padding(.leading)
                    
                    TextEditor(text: $inputText)
                        .frame(height: 100)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.2))
                        )
                }
                .padding(.horizontal)
                
                // Gradient Translate Button
                Button {
                    Task {
                        isTranslating = true
                        do {
                            try await translationManager.translate(
                                text: inputText,
                                from: fromLanguage.code,
                                to: toLanguage.code
                            )
                            inputText = ""
                        } catch {
                            print("Translation error: \(error)")
                        }
                        isTranslating = false
                    }
                } label: {
                    HStack {
                        if isTranslating {
                            ProgressView()
                                .tint(.white)
                        }
                        Text("Translate")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.blue, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(15)
                }
                .padding(.horizontal)
                .disabled(inputText.isEmpty || isTranslating)
                
                // Output Field
                if let latestTranslation = translationManager.translations.first {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Translation")
                            .foregroundStyle(.secondary)
                            .padding(.leading)
                        
                        Text(latestTranslation.translatedText)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.2))
                            )
                    }
                    .padding(.horizontal)
                }
                
                NavigationLink {
                    SavedTranslationsView()
                } label: {
                    Text("View Saved Translations")
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .cyan],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
                .padding(.top, 30)
                Spacer()
                Text("Created by Nam Nguyen - z23539620")
                    .font(.caption)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .padding(.bottom, 16)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(TranslationManager())
}
