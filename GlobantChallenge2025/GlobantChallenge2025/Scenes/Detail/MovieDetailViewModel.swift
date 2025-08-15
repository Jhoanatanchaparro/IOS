//
//  MovieDetailViewModel.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 5/08/25.
//

import Foundation

final class MovieDetailViewModel: ObservableObject {
    @Published private(set) var movie: Movie
    @Published private(set) var isFavorite: Bool = false
    
    private let service = MovieLocalService()

    init(movie: Movie) {
        self.movie = movie
        self.isFavorite = fetchIsFavorite()
    }
    
    func loadFavoriteStatus() {
        isFavorite = fetchIsFavorite()
    }

    var favoriteStatus: FavoriteStatus {
        FavoriteStatus.from(isFavorite: isFavorite)
    }

    var formattedReleaseDate: String {
        movie.releaseDate?.formatted(date: .long, time: .omitted) ?? "Sin fecha"
    }

    var formattedGenres: String {
        movie.genres.isEmpty ? "No disponibles" : movie.genres.joined(separator: ", ")
    }

    func toggleFavorite() {
        service.toggleFavorite(movie: movie)
        isFavorite = fetchIsFavorite()
    }

    private func fetchIsFavorite() -> Bool {
        let request = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movie.id)
        return (try? CoreDataStack.context.fetch(request))?.isEmpty == false
    }
}

