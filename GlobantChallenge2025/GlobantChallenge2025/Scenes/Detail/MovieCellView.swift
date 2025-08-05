//
//  MovieCellView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 22/07/25.
//

import SwiftUI

struct MovieCellView: View {
    let movie: Movie
    var showRating: Bool = true

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            PosterImageView(url: movie.posterURL)
                .frame(width: 90, height: 130)

            VStack(alignment: .leading, spacing: 6) {
                TitleView(title: movie.title)
                
                ReleaseDateView(releaseDate: movie.releaseDate)
                
                RatingView(rating: movie.voteAverage / 2.0, isVisible: showRating)
                
                Spacer()
            }
            .frame(maxHeight: 130)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.primary.opacity(0.05), radius: 4, x: 0, y: 2)
        .frame(minHeight: 150)
    }
}

struct PosterImageView: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url) { phase in
            phase.image?
                .resizable()
                .scaledToFill()
                .clipped()
                .cornerRadius(8)
        }
    }
}

struct TitleView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.primary)
            .lineLimit(2)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct ReleaseDateView: View {
    let releaseDate: Date?

    var body: some View {
        Group {
            if let date = releaseDate {
                Text("Fecha de lanzamiento: \(date.formatted())")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct RatingView: View {
    let rating: Double
    let isVisible: Bool

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                let starPosition = Double(index)
                Image(systemName: starImage(for: starPosition))
                    .foregroundColor(.yellow)
            }
        }
        .opacity(isVisible ? 1 : 0)
    }
    
    private func starImage(for position: Double) -> String {
        if rating >= position + 1 {
            return "star.fill"
        } else if rating > position && rating < position + 1 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}
