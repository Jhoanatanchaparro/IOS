//
//  Movie.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//

import Foundation

struct Movie: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterURL: URL?
    let releaseDate: Date?
    let popularity: Double
    var isFavorite: Bool
    let genres: [String]
    let voteAverage: Double
    let translatedTitle: String?
}
