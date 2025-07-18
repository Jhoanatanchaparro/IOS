//
//  MovieRemoteService.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 17/07/25.
//

import Foundation
class MovieRemoteService : MovieService{
    private let session : URLSession
    private let apiKey = "674d3fd8acf60310780d837db7e2fe17"
    
    init(session: URLSession = .shared){
        self.session = session
    }
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
            let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=es")!

            session.dataTask(with: url) { data, _, error in
                let result = data
                    .flatMap { try? JSONDecoder().decode(MovieResponseDTO.self, from: $0) }
                    .map { $0.results.map { $0.toDomain() } }
                    .map(Result.success) ?? error.map(Result.failure)

                completion(result ?? .failure(NSError(domain: "unknown", code: 0)))
            }.resume()
        }
}

//https://api.themoviedb.org/3/movie/popular?api_key=674d3fd8acf60310780d837db7e2fe17&language=es
