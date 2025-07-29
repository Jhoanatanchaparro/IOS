//
//  TabItem.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 21/07/25.
//
import SwiftUI


enum TabItem: Int, CaseIterable {
    case movies, favorites, settings
    
    var title: String {
        [
            .movies: "movies.title".localized,
            .favorites: "favorites.title".localized,
            .settings: "settings.title".localized
        ][self]!
    }
    
    var icon: String {
        [
            .movies: "film",
            .favorites: "star.fill",
            .settings: "gear"
        ][self]!
    }
    
    var view: AnyView {
        [
            .movies: AnyView(
                MoviesView(viewModel:
                    MoviesViewModel(
                        interactor: MoviesInteractor(service: MovieRemoteService()),
                        titleKey: "movies.title"
                    )
                )
            ),
            .favorites: AnyView(
                MoviesView(viewModel:
                    MoviesViewModel(
                        interactor: MoviesInteractor(service: MovieLocalService()),
                        titleKey: "favorites.title"
                    )
                )
            ),
            .settings: AnyView(ThemeSettingsView())
        ][self]!
    }
}
