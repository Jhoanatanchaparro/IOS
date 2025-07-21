//
//  TabItem.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 21/07/25.
//
// Presentation/Scenes/Tab/TabItem.swift

import SwiftUI

enum TabItem: Int, CaseIterable {
    case movies, favorites

    var title: String {
        [.movies: "Cartelera", .favorites: "Favoritos"][self]!
    }

    var icon: String {
        [.movies: "film", .favorites: "star.fill"][self]!
    }

    var view: AnyView {
        let viewMap: [TabItem: AnyView] = [
            .movies: AnyView(
                CarsListView(viewModel:
                    CarsListViewModel(interactor:
                        MoviesInteractor(service: MovieRemoteService())
                    )
                )
            ),
            .favorites: AnyView(
                CarsListView(viewModel:
                    CarsListViewModel(interactor:
                        MoviesInteractor(service: MovieLocalService())
                    )
                )
            )
        ]
        return viewMap[self]!
    }
}

