//
//  CarDetailView.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//


import SwiftUI

struct CarDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel
    @State private var isLoading: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: viewModel.movie.posterURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .clipped()
                        case .failure:
                            Color.red
                                .frame(height: 250)
                        default:
                            Color.gray.opacity(0.3)
                                .frame(height: 250)
                        }
                    }
                    .cornerRadius(12)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.movie.title)
                            .font(.title2)
                            .bold()
                        
                        Text("Fecha de lanzamiento: \(viewModel.formattedReleaseDate)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    StarRatingView(rating: viewModel.movie.voteAverage)

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Géneros:")
                            .font(.headline)
                        
                        Text(viewModel.formattedGenres)
                            .foregroundColor(viewModel.movie.genres.isEmpty ? .gray : .primary)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Descripción:")
                            .font(.headline)

                        Text(viewModel.movie.overview.isEmpty ? "Descripción no disponible." : viewModel.movie.overview)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .italic(viewModel.movie.overview.isEmpty)
                    }
                }
                .padding()
            }
            .onAppear {
                isLoading = true
                viewModel.loadFavoriteStatus()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isLoading = false
                }
            }
            .onDisappear {
                NotificationCenter.default.post(name: Notification.Name("RefreshMoviesList"), object: nil)
            }

            if isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
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


