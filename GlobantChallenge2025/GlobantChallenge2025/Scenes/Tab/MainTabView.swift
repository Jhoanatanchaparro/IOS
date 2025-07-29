//
//  MainTabView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 21/07/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabItem = .movies
    
    var body: some View {
        TabView {
                    MoviesView(viewModel: MoviesViewModel(
                        interactor: MoviesInteractor(service: MovieRemoteService()),
                        titleKey: "movies.title"
                    ))
                    .tabItem {
                        Label("Películas", systemImage: "film")
                    }

                    MoviesView(viewModel: MoviesViewModel(
                        interactor: MoviesInteractor(service: MovieLocalService()),
                        titleKey: "favorites.title"
                    ))
                    .tabItem {
                        Label("Favoritos", systemImage: "star")

                    }
                }
            }
        }
