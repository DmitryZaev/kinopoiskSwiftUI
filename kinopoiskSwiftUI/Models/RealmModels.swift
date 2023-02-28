//
//  RealmModels.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 26.02.2023.
//

import Foundation
import RealmSwift

class FavoriteMovie: Object, ObjectKeyIdentifiable {
    @Persisted var name: String
    @Persisted var imageUrlString : String
    @Persisted var genres: String
    @Persisted var movieID: Int
}

class FavoritesMoviesGroup: Object, ObjectKeyIdentifiable {
    @Persisted var movies = RealmSwift.List<FavoriteMovie>()
}
