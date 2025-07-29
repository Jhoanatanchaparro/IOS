//
//  CarDetailView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//


import SwiftUI

struct CarDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel

    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: viewModel.movie.posterURL) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .clipped()
                        } else if phase.error != nil {
                            Color.red
                                .frame(height: 250)
                        } else {
                            Color.gray.opacity(0.3)
                                .frame(height: 250)
                        }
                    }
                    .cornerRadius(12)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.movie.title)
                            .font(.title2)
                            .bold()
                        
                        Text("Fecha de lanzamiento:\n\(viewModel.formattedReleaseDate)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    StarRatingView(rating: viewModel.movie.voteAverage)

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Géneros:")
                            .font(.headline)
                        if viewModel.movie.genres.isEmpty {
                            Text("No disponibles")
                                .foregroundColor(.gray)
                        } else {
                            Text(viewModel.movie.genres.joined(separator: " • "))
                        }
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Descripción:")
                            .font(.headline)

                        Text(viewModel.movie.overview)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
            }
        
            .navigationTitle("movie.detail".localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.toggleFavorite()
                    }) {
                        Image(systemName: viewModel.favoriteStatus.icon)
                            .foregroundColor(viewModel.favoriteStatus.color)
                    }
                }
            }
        }
}

