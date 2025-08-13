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

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ZStack {
            NavigationView {
                contentView
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
            .onAppear {
                reloadData()
                isLoading = true
                viewModel.loadMovies()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isLoading = false
                }
            }

            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .overlay(
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)
                )
                .opacity(isLoading ? 1 : 0)
        }
    }

    @ViewBuilder
    private var contentView: some View {
        [
            "movies.title".localized: AnyView(movieListView),
            "favorites.title".localized: AnyView(favoritesListView)
        ][viewModel.titleKey.localized] ?? AnyView(EmptyView())
    }

    @ViewBuilder
    private var favoritesListView: some View {
        Group {
            emptyFavoritesView
                .opacity(viewModel.filteredMovies.isEmpty ? 1 : 0)
            favoritesGridView
                .opacity(viewModel.filteredMovies.isEmpty ? 0 : 1)
        }
    }

    private var emptyFavoritesView: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
                .foregroundColor(.blue)

            Text((viewModel.searchText.isEmpty ? "Aún no tienes elementos favoritos agregados" : "No se encontraron resultados para la búsqueda de:"))
                .multilineTextAlignment(.center)
                .font(.headline)
                .foregroundColor(.gray)

            Text(viewModel.searchText)
                .font(.headline)
                .foregroundColor(.gray)
                .opacity(viewModel.searchText.isEmpty ? 0 : 1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }

    private var favoritesGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.filteredMovies, id: \.id) { movie in
                    NavigationLink(
                        destination: CarDetailView(viewModel: MovieDetailViewModel(movie: movie))
                    ) {
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
            noResultsView
                .opacity(viewModel.noResults ? 1 : 0)
            movieList
                .opacity(viewModel.noResults ? 0 : 1)
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
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.systemGray6))
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)

                    NavigationLink(
                        destination: CarDetailView(viewModel: MovieDetailViewModel(movie: movie))
                            .onDisappear {
                                reloadData()
                            }
                    ) {
                        MovieCellView(movie: movie, showRating: true)
                            .padding()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .listRowSeparator(.hidden)
                .padding(.vertical, 4)
            }
        }
        .listStyle(.plain)
        .refreshable {
            isLoading = true
            viewModel.loadMovies()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false
            }
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

    private func reloadData() {
        isLoading = true
        viewModel.loadMovies()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isLoading = false
        }
    }
}
