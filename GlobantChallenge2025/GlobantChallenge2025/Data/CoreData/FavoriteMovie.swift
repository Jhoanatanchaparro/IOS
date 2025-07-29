//
//  FavoriteMovie+CoreData.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//

import CoreData

@objc(FavoriteMovie)
public class FavoriteMovie: NSManagedObject {}

extension FavoriteMovie {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var overview: String
    @NSManaged public var posterURL: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var popularity: Double
    @NSManaged public var genres: [String]?
    @NSManaged public var voteAverage: Double
    @NSManaged public var translatedTitle: String?

    
    func toDomain() -> Movie {
            return Movie(
                id: Int(self.id),
                title: self.title,
                overview: self.overview,
                posterURL: URL(string: self.posterURL ?? ""),
                releaseDate: self.releaseDate,
                popularity: self.popularity,
                isFavorite: true,
                genres: self.genres ?? [],
                voteAverage: self.voteAverage,
                translatedTitle: self.translatedTitle
            )
        }

        static func fromDomain(_ movie: Movie, context: NSManagedObjectContext) -> FavoriteMovie {
            let entity = FavoriteMovie(context: context)
            entity.id = Int64(movie.id)
            entity.title = movie.title
            entity.overview = movie.overview
            entity.posterURL = movie.posterURL?.absoluteString
            entity.releaseDate = movie.releaseDate
            entity.popularity = movie.popularity
            entity.genres = movie.genres
            entity.voteAverage = movie.voteAverage
            entity.translatedTitle = movie.translatedTitle
            return entity
        }
    }


