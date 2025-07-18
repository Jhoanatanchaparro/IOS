//
//  CarDetailViewModel.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//

import Foundation

final class CarDetailViewModel: ObservableObject{
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var favoriteStatus: FavoriteStatus{
        FavoriteStatus.from(isFavorite: movie.isFavorite)
    }
}
