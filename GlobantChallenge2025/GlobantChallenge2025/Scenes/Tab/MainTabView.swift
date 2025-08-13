//
//  MainTabView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 21/07/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabItem = .movies
    @State private var movieSelection: Movie? = nil
    @State private var favoriteSelection: Movie? = nil

    var body: some View {
        TabView(selection: $selectedTab) {
            
            MoviesView(
                viewModel: MoviesViewModel(
                    interactor: MoviesInteractor(service: MovieRemoteService()),
                    titleKey: "movies.title"
                ),
                selectedMovie: $movieSelection,
                selectedFavorite: $favoriteSelection
            )
            .tabItem {
                Label(TabItem.movies.title, systemImage: TabItem.movies.icon)
            }
            .tag(TabItem.movies)
            
            MoviesView(
                viewModel: MoviesViewModel(
                    interactor: MoviesInteractor(service: MovieLocalService()),
                    titleKey: "favorites.title"
                ),
                selectedMovie: $movieSelection,
                selectedFavorite: $favoriteSelection
            )
            .tabItem {
                Label(TabItem.favorites.title, systemImage: TabItem.favorites.icon)
            }
            .tag(TabItem.favorites)
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            if newValue == .movies {
                favoriteSelection = nil // salir de detalle de favoritos
                movieSelection = nil    // asegurarse que la lista esté limpia
            } else if newValue == .favorites {
                movieSelection = nil
                favoriteSelection = nil
            }
        }
    }
    
}
