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
    
    @AppStorage("appTheme") private var selectedThemeRawValue: String = AppTheme.system.rawValue
    
    var selectedTheme: AppTheme {
        AppTheme(rawValue: selectedThemeRawValue) ?? .system
    }

    var body: some Scene {
        WindowGroup {
            contentView
                .environmentObject(session)
                .preferredColorScheme(selectedTheme.colorScheme)
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        session.isLoggedIn ? AnyView(MainTabView()) : AnyView(LoginView())
    }
}
