//
//  MovieDTO.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 17/07/25.
//

import Foundation
struct MovieDTO : Decodable{
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let release_date : String?
    let popularity : Double
    
    func toDomain(isFavorite: Bool = false) ->  Movie{
        Movie(
            id: id,
            title: title,
            overview: overview,
            posterURL: poster_path.flatMap { URL(string: "https://image.tmdb.org/t/p/w500\($0)") },
            releaseDate: release_date?.toDate(),
            popularity: popularity,
            isFavorite: isFavorite
        )
    }
}
