//
//  AppTheme.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 22/07/25.
//

import SwiftUI

enum AppTheme: String, CaseIterable {
    case system, light, dark
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
    
    var label: String {
        switch self {
        case .system: return "Sistema"
        case .light: return "Claro"
        case .dark: return "Oscuro"
        }
    }
}
