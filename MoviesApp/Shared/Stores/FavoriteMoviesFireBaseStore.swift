//
//  FireBaseMovieListAutenticator..swift
//  MoviesApp
//
//  Created by 1 on 20.11.2023.
//

import Foundation
import Firebase

class FavoriteMoviesFireBaseStore {
    private let database = Firestore.firestore()
    
    private var userID: String {
        let currentUser = Auth.auth().currentUser!
        let userID = currentUser.uid
        return userID
    }
    
    func add(movie: Movie) {
        database.collection("users/\(userID)/favorites").addDocument(data: [
            "title": movie.title,
            "thumbnailImageName": movie.thumbnailImageName,
            "year": movie.year,
            "genre": movie.genre,
            "description": movie.description
        ])
    }
    
    func remove(movie: Movie) {
        database.document("users/\(userID)/favorites/\(movie.id)").delete()
    }
}
