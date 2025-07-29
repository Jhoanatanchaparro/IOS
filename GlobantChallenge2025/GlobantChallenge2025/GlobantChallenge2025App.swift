//
//  GlobantChallenge2025App.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 17/07/25.
//

import SwiftUI
@main
struct DemoSwiftUIApp: App {
    @StateObject var session = SessionManager()
        
        // Persistimos la selección de tema
        @AppStorage("appTheme") private var selectedThemeRawValue: String = AppTheme.system.rawValue
        
        var selectedTheme: AppTheme {
            AppTheme(rawValue: selectedThemeRawValue) ?? .system
        }

        var body: some Scene {
            WindowGroup {
                if session.isLoggedIn {
                    MainTabView()
                        .environmentObject(session)
                        .preferredColorScheme(selectedTheme.colorScheme)
                } else {
                    LoginView()
                        .environmentObject(session)
                        .preferredColorScheme(selectedTheme.colorScheme)
                }
            }
        }
    }

