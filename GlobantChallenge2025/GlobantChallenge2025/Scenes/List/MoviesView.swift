//
//  MoviesView.swift
//  GlobantChallenge2025
//
import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel: MoviesViewModel
    @EnvironmentObject var session: SessionManager

    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            contentByKey[viewModel.titleKey.localized]!
                .navigationTitle(viewModel.titleKey.localized)
                .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Cerrar Sesión") {
                                    session.logout()
                                }
                            }
                        }
        }
        .searchable(text: $viewModel.searchText, prompt: "search.prompt".localized)
        .onAppear { viewModel.loadMovies() }
    }
    
    var contentByKey: [String: AnyView] {
        [
            "movies.title".localized: AnyView(movieListView),
            "favorites.title".localized: AnyView(favoritesListView)
        ]
        
    }
    
    var favoritesListView: some View {
        Group {
            if viewModel.filteredMovies.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)

                    if viewModel.searchText.isEmpty {
                        Text("Aún no tienes elementos favoritos agregados")
                            .multilineTextAlignment(.center)
                            .font(.headline)
                            .foregroundColor(.gray)
                    } else {
                        Text("No se encontraron resultados para la búsqueda de:")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)

                        Text(viewModel.searchText)
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.filteredMovies, id: \.id) { movie in
                            NavigationLink(
                                destination: CarDetailView(viewModel: MovieDetailViewModel(movie: movie))
                            ) {
                                VStack(alignment: .leading, spacing: 6) {
                                    AsyncImage(url: movie.posterURL) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 200)
                                            .frame(maxWidth: .infinity)
                                            .clipped()
                                    } placeholder: {
                                        Color.gray.opacity(0.3)
                                            .frame(height: 200)
                                            .frame(maxWidth: .infinity)
                                    }
                                    .cornerRadius(12)

                                    Text(movie.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .lineLimit(2)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    Text("Fecha de lanzamiento:\n\(movie.releaseDate?.formatted(date: .long, time: .omitted) ?? "Sin fecha")")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .lineLimit(2)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    var movieListView: some View {
        Group {
            if viewModel.noResults {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                    
                    Text("No se encontraron resultados para la búsqueda de:")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                    
                    Text(viewModel.searchText)
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            } else {
                List(viewModel.filteredMovies) { movie in
                    NavigationLink(
                        destination: CarDetailView(viewModel: MovieDetailViewModel(movie: movie))
                    ) {
                        MovieCellView(movie: movie, showRating: true)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .refreshable {
                    viewModel.loadMovies()
                }
            }
        }
    }
    
}



