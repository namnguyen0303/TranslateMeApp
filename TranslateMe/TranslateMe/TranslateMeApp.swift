//
//  TranslateMeApp.swift
//  TranslateMe
//
//  Created by Nam Nguyen on 11/13/24.
//

import SwiftUI
import FirebaseCore

@main
struct TranslateMeApp: App {
    @State private var translationManager: TranslationManager
    
    init() {
        FirebaseApp.configure()
        translationManager = TranslationManager()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(translationManager)
        }
    }
}
