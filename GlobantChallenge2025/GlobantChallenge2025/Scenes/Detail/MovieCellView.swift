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
            AsyncImage(url: movie.posterURL) { phase in
                phase.image?
                    .resizable()
                    .scaledToFill()
            }
            .frame(width: 90, height: 130)
            .clipped()
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                movie.releaseDate.map {
                    Text("Fecha de lanzamiento:\n\($0.formatted())")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                if showRating {
                    let rating = movie.voteAverage / 2.0
                    HStack(spacing: 2) {
                        ForEach(0..<5, id: \.self) { index in
                            let starPosition = Double(index)
                            if rating >= starPosition + 1 {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            } else if rating > starPosition && rating < starPosition + 1 {
                                Image(systemName: "star.leadinghalf.filled")
                                    .foregroundColor(.yellow)
                            } else {
                                Image(systemName: "star")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                }
                
                
                Spacer()
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.primary.opacity(0.05), radius: 4, x: 0, y: 2)
        }
    }
    
}
