//
//  FireBaseSignInAuthenticator.swift
//  MoviesApp
//
//  Created by 1 on 20.11.2023.
//

import Foundation
import Firebase

class FireBaseSignInAuthenticator {
    func signIn(email: String, password: String, completionHandler: @escaping (Result<Void, SignInError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if let error = error {
                completionHandler(.failure(SignInError(rawValue: error.localizedDescription) ?? .incorrectData))
            }
            
            if let result = result {
                print(result)
                completionHandler(.success(Void()))
            }
            
        }
    }
}
