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

        let result: Result<[Movie], Error> = (try? context.fetch(request))
            .map { $0.map { $0.toDomain() } }
            .map(Result.success) ?? .failure(NSError(domain: "local", code: 0))

        completion(result)
    }

    func save(movie: Movie) {
        _ = FavoriteMovie.fromDomain(movie, context: context)
        CoreDataStack.save()
    }

    func delete(movie: Movie) {
        fetchById(movie.id)
            .forEach(context.delete)
        CoreDataStack.save()
    }

    func toggleFavorite(movie: Movie) {
        let exists = !fetchById(movie.id).isEmpty

        [
            true: { self.delete(movie: movie) },
            false: { self.save(movie: movie) }
        ][exists]?()
    }

    private func fetchById(_ id: Int) -> [FavoriteMovie] {
        let request = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        return (try? context.fetch(request)) ?? []
    }
}

