//
//  ThemeSettingsView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 22/07/25.
//

//
//  ThemeSettingsView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 22/07/25.
//
import SwiftUI

struct ThemeSettingsView: View {
    @EnvironmentObject var theme: ThemeViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Apariencia")) {
                Picker("Modo de apariencia", selection: $theme.selectedTheme) {
                    ForEach(AppTheme.allCases, id: \.self) {
                        Text($0.label).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .navigationTitle("Configuración")
    }
}


