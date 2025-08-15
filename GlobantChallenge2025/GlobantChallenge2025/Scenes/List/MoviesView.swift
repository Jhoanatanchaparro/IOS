//
//  MoviesView.swift
//  GlobantChallenge2025
//
import SwiftUI

struct MoviesView: View {
    @StateObject var viewModel: MoviesViewModel
    @EnvironmentObject var session: SessionManager
    @State private var isLoading: Bool = false
    @Binding var selectedMovie: Movie?
    @Binding var selectedFavorite: Movie?

    @State private var path: [Movie] = []

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ZStack {
            NavigationStack(path: $path) {
                contentView
                    .navigationTitle(viewModel.titleKey.localized)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Cerrar Sesión") {
                                session.logout()
                            }
                        }
                    }
                    .searchable(text: $viewModel.searchText, prompt: "search.prompt".localized)
                    .navigationDestination(for: Movie.self) { movie in
                        CarDetailView(viewModel: MovieDetailViewModel(movie: movie))
                            .onDisappear {
                                reloadData(force: viewModel.isFavoriteView)
                            }
                    }
                    .onAppear {
                        reloadData(force: viewModel.isFavoriteView)
                    }
            }

            if isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(2)
                    )
            }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if viewModel.titleKey.localized == "movies.title".localized {
            movieListView
        } else if viewModel.titleKey.localized == "favorites.title".localized {
            favoritesListView
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private var favoritesListView: some View {
        Group {
            if viewModel.filteredMovies.isEmpty {
                emptyFavoritesView
            } else {
                favoritesGridView
            }
        }
    }

    private var emptyFavoritesView: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
                .foregroundColor(.blue)

            Text(viewModel.searchText.isEmpty
                 ? "Aún no tienes elementos favoritos agregados"
                 : "No se encontraron resultados para la búsqueda de:")
                .multilineTextAlignment(.center)
                .font(.headline)
                .foregroundColor(.gray)

            if !viewModel.searchText.isEmpty {
                Text(viewModel.searchText)
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }

    private var favoritesGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.filteredMovies, id: \.id) { movie in
                    NavigationLink(value: movie) {
                        movieCellView(for: movie)
                    }
                }
            }
            .padding()
        }
    }

    @ViewBuilder
    private var movieListView: some View {
        Group {
            if viewModel.noResults {
                noResultsView
            } else {
                movieList
            }
        }
    }

    private var noResultsView: some View {
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
    }

    private var movieList: some View {
        List {
            ForEach(viewModel.filteredMovies) { movie in
                NavigationLink(value: movie) {
                    MovieCellView(movie: movie, showRating: true)
                        .padding()
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .listStyle(.plain)
        .refreshable {
            reloadData(delay: 2, force: viewModel.isFavoriteView)
        }
    }

    private func movieCellView(for movie: Movie) -> some View {
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

            Text("Fecha de lanzamiento: \(movie.releaseDate?.formatted(date: .long, time: .omitted) ?? "Sin fecha")")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func reloadData(delay: Double = 1, force: Bool = false) {
        isLoading = true
        viewModel.loadMovies(forceReload: force)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            isLoading = false
        }
    }
}
