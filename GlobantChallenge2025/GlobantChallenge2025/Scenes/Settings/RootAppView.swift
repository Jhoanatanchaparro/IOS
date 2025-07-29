//
//  RootAppView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 22/07/25.
//

import SwiftUI

struct RootAppView: View {
    @EnvironmentObject var themeVM: ThemeViewModel

    var body: some View {
        MainTabView()
            .preferredColorScheme(themeVM.selectedTheme.colorScheme)
    }
}
