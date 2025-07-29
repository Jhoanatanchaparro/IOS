//
//  MovieDTO.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 17/07/25.
//

import Foundation
struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let release_date: String?
    let popularity: Double
    let genre_ids: [Int]
    let vote_average: Double
    let original_title: String?
    
    func toDomain(isFavorite: Bool = false) -> Movie {
        let mappedGenres = genre_ids.compactMap { GenreMapper.map[$0] }
        if mappedGenres.isEmpty {
            print("⚠️ Sin géneros mapeados para: \(title), ids: \(genre_ids)")
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let parsedDate = release_date.flatMap { formatter.date(from: $0) }

        return Movie(
            id: id,
            title: title,
            overview: overview,
            posterURL: poster_path.flatMap { URL(string: "https://image.tmdb.org/t/p/w500\($0)") },
            releaseDate: parsedDate,
            popularity: popularity,
            isFavorite: isFavorite,
            genres: genre_ids.compactMap { GenreMapper.map[$0] },
            voteAverage: vote_average,
            translatedTitle:original_title
        )
    }
}
