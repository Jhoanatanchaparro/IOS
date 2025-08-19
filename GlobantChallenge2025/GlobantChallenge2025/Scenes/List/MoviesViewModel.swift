//
//  MoviesViewModel.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 22/07/25.

import Foundation

final class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false

    let titleKey: String
    private let interactor: MoviesInteractor
    private var hasLoaded: Bool = false

    init(interactor: MoviesInteractor, titleKey: String) {
        self.interactor = interactor
        self.titleKey = titleKey
    }
    
    func loadMovies(forceReload: Bool = false) {
        guard forceReload || !hasLoaded else { return }
        
        isLoading = true
        interactor.getMovies { [weak self] movies in
            DispatchQueue.main.async {
                self?.movies = movies
                self?.isLoading = false
                self?.hasLoaded = true
            }
        }
    }
    
    func toggleFavorite(for movie: Movie) {
        interactor.toggleFavorite(movie)

        isFavoriteView ? loadMovies(forceReload: true) : updateMovieFavoriteStatus(for: movie)
    }
    
    private func updateMovieFavoriteStatus(for movie: Movie) {
        guard let index = movies.firstIndex(where: { $0.id == movie.id }) else { return }
        var updatedMovie = movies[index]
        updatedMovie.isFavorite.toggle()
        movies[index] = updatedMovie
    }
    
    var filteredMovies: [Movie] {
        let query = searchText.normalized().trimmingCharacters(in: .whitespacesAndNewlines)
        return query.isEmpty ? movies : movies.filter { movie in
            movie.title.normalized().contains(query) ||
            (movie.translatedTitle?.normalized().contains(query) ?? false)
        }
    }
    
    var isFavoriteView: Bool {
        interactor.service is MovieLocalService
    }
    
    var noResults: Bool {
        !searchText.isEmpty && filteredMovies.isEmpty
    }
}
