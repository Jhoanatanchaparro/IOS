//
//  AppTheme.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 22/07/25.
//

import SwiftUI

enum AppTheme: String, CaseIterable{
    case system, light, dark
    
    var colorScheme: ColorScheme? {
        [.system: nil, .light: .light, .dark: .dark][self]!
    }
    
    var label: String{
        [.system: "Sistema", .light: "Claro", .dark: "Oscuro"][self]!
    }
}
