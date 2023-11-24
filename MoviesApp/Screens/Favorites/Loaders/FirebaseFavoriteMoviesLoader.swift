//
//  FirebaseFavoriteMoviesLoader.swift
//  MoviesApp
//
//  Created by 1 on 23.11.2023.
//

import Foundation
import Firebase

class FirebaseFavoriteMoviesLoader {
    func load(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        let database = Firestore.firestore()
        
        let currentUser = Auth.auth().currentUser!
        
        let userID = currentUser.uid

        database.collection("users/\(userID)/favorites").getDocuments {  [weak self] snapshotResult, error in
            
            if error != nil {
                return
            }

            let movies = snapshotResult?.documents.compactMap { document in
                let data = document.data()
                return Movie(id: document.documentID,
                             thumbnailImageName: data["thumbnailImageName"] as! String,
                             title: data["title"] as! String,
                             year: data["year"] as! Int,
                             genre: data["genre"] as! String,
                             isFavorite: true,
                             description: data["description"] as! String)
            }
            
            completionHandler(.success(movies ?? []))
        }
    }
}
