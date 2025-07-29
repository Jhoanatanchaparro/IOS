//
//  ThemeViewModel.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 22/07/25.
//

import SwiftUI

final class ThemeViewModel: ObservableObject {
    @Published var selectedTheme: AppTheme = .system {
        didSet {
            UserDefaults.standard.set(selectedTheme.rawValue, forKey: "AppTheme")
        }
    }

    init() {
        let raw = UserDefaults.standard.string(forKey: "AppTheme") ?? "system"
        selectedTheme = AppTheme(rawValue: raw) ?? .system
    }
}
