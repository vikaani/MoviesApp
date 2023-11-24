//
//  FirebaseUserAvatarImageStore.swift
//  MoviesApp
//
//  Created by 1 on 23.11.2023.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseUserAvatarImageStore {
    func save(imageData: Data) {
        getCurrentUserAvatarImagesStorageReference().putData(imageData)
    }
    
    func getImageData(completionHandler: @escaping (Result<Data,Error>) -> Void) {
        getCurrentUserAvatarImagesStorageReference().getData(maxSize: 3 * 1024 * 1024) { data, error in
            guard let data = data else { return }
            completionHandler(.success(data))
        }
    }
    
    private func getCurrentUserAvatarImagesStorageReference() -> StorageReference {
        let userID = Auth.auth().currentUser!.uid
        let storage = Storage.storage().reference()
        
        return storage.child("avatars/\(userID)")
    }
}


