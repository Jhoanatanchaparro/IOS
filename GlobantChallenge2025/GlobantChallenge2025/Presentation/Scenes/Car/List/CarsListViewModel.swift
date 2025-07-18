//
//  CarsListViewModel.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//

import Foundation
import Combine

final class CarsListViewModel: ObservableObject{
    @Published var movies: [Movie] = []
    private let interactor: MoviesInteractor
    
    init(interactor: MoviesInteractor){
        self.interactor = interactor
    }
    
    func loadMovies() {
        interactor.getMovies { [weak self] movies in
            DispatchQueue.main.async {
                self?.movies = movies
            }
        }
    }
}
