//
//  FavoriteMovie+CoreData.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//

// Data/CoreData/FavoriteMovie+CoreData.swift
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
    @NSManaged public var popularity: Double
    @NSManaged public var releaseDate: Date?

    func toDomain() -> Movie {
        Movie(
            id: Int(id),
            title: title,
            overview: overview,
            posterURL: posterURL.flatMap(URL.init(string:)),
            releaseDate: releaseDate,
            popularity: popularity,
            isFavorite: true
        )
    }

    static func fromDomain(_ movie: Movie, context: NSManagedObjectContext) -> FavoriteMovie {
        let fav = FavoriteMovie(context: context)
        fav.id = Int64(movie.id)
        fav.title = movie.title
        fav.overview = movie.overview
        fav.posterURL = movie.posterURL?.absoluteString
        fav.popularity = movie.popularity
        fav.releaseDate = nil 
        return fav
    }
}

