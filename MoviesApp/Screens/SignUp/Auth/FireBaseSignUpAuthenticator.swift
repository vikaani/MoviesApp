//
//  FireBaseSignUpAutenticator.swift
//  MoviesApp
//
//  Created by 1 on 23.11.2023.
//
import Foundation
import Firebase

class FireBaseSignUpAuthenticator {
    func createUser(email: String, password: String, completionHandler: @escaping (Result<Void, SignUpError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error = error {
                completionHandler(.failure(SignUpError(rawValue: error.localizedDescription) ?? .incorrectData))
            }
            
            if let result = result {
                print(result)
                completionHandler(.success(Void()))
            }
        }
    }
}
