//
//  CarDetailViewModel.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//

import Foundation

final class CarDetailViewModel: ObservableObject {
    @Published private(set) var movie: Movie
    private let service = MovieLocalService()

    init(movie: Movie) {
        self.movie = movie
    }

    var favoriteStatus: FavoriteStatus {
        let request = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movie.id)
        let isSaved = (try? CoreDataStack.context.fetch(request))?.isEmpty == false
        return FavoriteStatus.from(isFavorite: isSaved)
    }

    func toggleFavorite() {
        service.toggleFavorite(movie: movie)

        let toggle: [Bool: Bool] = [true: false, false: true]
        movie = Movie(
            id: movie.id,
            title: movie.title,
            overview: movie.overview,
            posterURL: movie.posterURL,
            releaseDate: movie.releaseDate,
            popularity: movie.popularity,
            isFavorite: toggle[movie.isFavorite]!
        )
    }
    
}
