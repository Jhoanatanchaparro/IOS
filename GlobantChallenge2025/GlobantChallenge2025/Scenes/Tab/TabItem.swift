//
//  TabItem.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 21/07/25.
//
import SwiftUI

enum TabItem: Int, CaseIterable {
    case movies, favorites
    
    var title: String {
        [
            .movies: "movies.title".localized,
            .favorites: "favorites.title".localized
        ][self]!
    }
    
    var icon: String {
        [
            .movies: "film",
            .favorites: "star.fill"
        ][self]!
    }
}

