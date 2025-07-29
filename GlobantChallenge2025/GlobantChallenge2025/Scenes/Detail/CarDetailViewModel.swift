//
//  CarDetailViewModel.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
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

    var favoriteStatus: FavoriteStatus {
        FavoriteStatus.from(isFavorite: isFavorite)
    }

    var formattedReleaseDate: String {
        movie.releaseDate?.formatted(date: .long, time: .omitted) ?? "Sin fecha"
    }

    var formattedGenres: String {
        if movie.genres.isEmpty {
            return "No disponibles"
        }
        return movie.genres.joined(separator: ", ")
    }

    func toggleFavorite() {
        service.toggleFavorite(movie: movie)
        isFavorite.toggle()
        
        movie = Movie(
            id: movie.id,
            title: movie.title,
            overview: movie.overview,
            posterURL: movie.posterURL,
            releaseDate: movie.releaseDate,
            popularity: movie.popularity,
            isFavorite: isFavorite,
            genres: movie.genres,
            voteAverage: movie.voteAverage,
            translatedTitle: movie.translatedTitle
        )
    }

    private func fetchIsFavorite() -> Bool {
        let request = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movie.id)
        return (try? CoreDataStack.context.fetch(request))?.isEmpty == false
    }
}
