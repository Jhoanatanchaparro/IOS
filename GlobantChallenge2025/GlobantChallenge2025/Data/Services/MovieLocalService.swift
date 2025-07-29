//
//  MovieLocalService.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 17/07/25.
//
import Foundation
import CoreData

class MovieLocalService: MovieService {
    private let context = CoreDataStack.context

    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let request = FavoriteMovie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

        do {
            let favoritos = try context.fetch(request)
            let movies = favoritos.map { $0.toDomain() }
            completion(.success(movies))
        } catch {
            completion(.failure(error))
        }
    }

    func save(movie: Movie) {
        _ = FavoriteMovie.fromDomain(movie, context: context)
        CoreDataStack.save()
    }

    func delete(movie: Movie) {
        fetchById(movie.id).forEach(context.delete)
        CoreDataStack.save()
    }

    func toggleFavorite(movie: Movie) {
        let context = CoreDataStack.context
        let request = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movie.id)

        if let existing = try? context.fetch(request).first {
            context.delete(existing)
        } else {
            let favorite = FavoriteMovie(context: context)
            favorite.id = Int64(movie.id)
            favorite.title = movie.title
            favorite.overview = movie.overview
            favorite.posterURL = movie.posterURL?.absoluteString
            favorite.releaseDate = movie.releaseDate
            favorite.voteAverage = movie.voteAverage
            favorite.genres = movie.genres
        }

        try? context.save()
    }

    private func fetchById(_ id: Int) -> [FavoriteMovie] {
        let request = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        return (try? context.fetch(request)) ?? []
    }
    func limpiarFavoritosSinFecha() {
        let request = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "releaseDate == nil")
        
        do {
            let sinFecha = try context.fetch(request)
            sinFecha.forEach(context.delete)
            try context.save()
            print("🧹 Favoritos sin fecha eliminados: \(sinFecha.count)")
        } catch {
            print("❌ Error al limpiar favoritos sin fecha: \(error.localizedDescription)")
        }
    }

    func actualizarFavoritosConGenerosSiFaltan() {
        let request = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "genres == nil OR genres.@count == 0")

        do {
            let favoritos = try context.fetch(request)
            var actualizados = 0

            for favorito in favoritos {
                let movieID = Int(favorito.id)
                if let peliculaConGeneros = buscarPeliculaEnCache(id: movieID),
                   !peliculaConGeneros.genres.isEmpty {
                    favorito.genres = peliculaConGeneros.genres
                    actualizados += 1
                }
            }

            if context.hasChanges {
                try context.save()
            }

            print("✅ Favoritos actualizados con géneros: \(actualizados)")
        } catch {
            print("❌ Error al actualizar géneros vacíos: \(error.localizedDescription)")
        }
    }

    private func buscarPeliculaEnCache(id: Int) -> Movie? {
        return nil
    }
}


