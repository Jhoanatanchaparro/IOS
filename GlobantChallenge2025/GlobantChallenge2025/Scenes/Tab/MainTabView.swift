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
    
    @State private var moviesPath: [Movie] = []
    @State private var favoritesPath: [Movie] = []
    
    @StateObject private var remoteVM = MoviesViewModel(
        interactor: MoviesInteractor(service: MovieRemoteService()),
        titleKey: "movies.title"
    )
    
    @StateObject private var favoritesVM = MoviesViewModel(
        interactor: MoviesInteractor(service: MovieLocalService()),
        titleKey: "favorites.title"
    )

    var body: some View {
        TabView(selection: $selectedTab) {
            
            MoviesView(
                viewModel: remoteVM,
                selectedMovie: $movieSelection,
                selectedFavorite: $favoriteSelection,
                path: $moviesPath
            )
            .tabItem {
                Label(TabItem.movies.title, systemImage: TabItem.movies.icon)
            }
            .tag(TabItem.movies)
            
            MoviesView(
                viewModel: favoritesVM,
                selectedMovie: $movieSelection,
                selectedFavorite: $favoriteSelection,
                path: $favoritesPath
            )
            .tabItem {
                Label(TabItem.favorites.title, systemImage: TabItem.favorites.icon)
            }
            .tag(TabItem.favorites)
        }
        .onChange(of: selectedTab) {
            switch selectedTab {
            case .movies:
                favoritesPath.removeAll()
            case .favorites:
                moviesPath.removeAll()
            }
        }
    }
}


