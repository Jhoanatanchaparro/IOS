//
//  FavoriteStatus.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//

import SwiftUI

enum FavoriteStatus {
    case active
    case inactive

    var icon: String {
        [.active: "star.fill", .inactive: "star"][self]!
    }

    var color: Color {
        [.active: .yellow, .inactive: .gray][self]!
    }

    static func from(isFavorite: Bool) -> Self {
        [true: .active, false: .inactive][isFavorite]!
    }
}

