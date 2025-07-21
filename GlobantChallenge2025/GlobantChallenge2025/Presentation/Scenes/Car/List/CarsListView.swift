//
//  CarsListView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//

import SwiftUI

struct CarsListView: View {
    @StateObject var viewModel: CarsListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.filteredMovies) { movie in
                NavigationLink(destination: CarDetailView(viewModel: CarDetailViewModel(movie: movie))) {
                    Text(movie.title)
                }
            }
            .navigationTitle("Películas")
        }
        .searchable(text: $viewModel.searchText, prompt: "Buscar película...")
        .onAppear { viewModel.loadMovies() }
    }
}
