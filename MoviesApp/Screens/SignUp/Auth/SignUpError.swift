//
//  SignUpError.swift
//  MoviesApp
//
//  Created by 1 on 24.11.2023.
//

import Foundation

enum SignUpError: String, Error {
    case userIsAlreadyExist = "This user is already exist."
    case inccorrectEmail = "Incorrect email address. Please try again."
    case incorrectData
}
