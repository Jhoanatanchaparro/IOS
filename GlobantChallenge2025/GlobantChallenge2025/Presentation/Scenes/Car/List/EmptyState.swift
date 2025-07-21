//
//  EmptyState.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 21/07/25.
//

// Presentation/Scenes/Car/List/EmptyState.swift

import SwiftUI

enum EmptyState {
    case noResults
    case noFavorites
    case apiError

    var message: String {
        [
            .noResults: "No se encontraron resultados",
            .noFavorites: "Aún no tienes elementos favoritos agregados",
            .apiError: "Información no disponible temporalmente. Inténtalo más tarde"
        ][self]!
    }

    var view: some View {
        Text(message)
            .font(.callout)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding()
    }
}
