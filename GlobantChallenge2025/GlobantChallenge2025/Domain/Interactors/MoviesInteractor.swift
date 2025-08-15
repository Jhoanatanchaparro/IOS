//
//  MoviesInteractor.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//
import Foundation

final class MoviesInteractor{
    private(set) var service: MovieService
    
    init(service: MovieService) {
        self.service = service
    }
    
    func getMovies(completion: @escaping ([Movie ]) -> Void){
        service.fetchMovies{ result in
            completion(result.successValue ?? [] )
        }
    }
    func toggleFavorite(_ movie: Movie) {
        if let localService = service as? MovieLocalService {
            localService.toggleFavorite(movie: movie)
        }
    }

}
