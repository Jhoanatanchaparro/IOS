//
//  MovieService.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 17/07/25.
//

import Foundation

protocol MovieService{
    func fetchMovies(completion: @escaping(Result<[Movie], Error>)->Void)
}
