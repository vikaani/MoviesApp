//
//  SignInError.swift
//  MoviesApp
//
//  Created by 1 on 24.11.2023.
//

import Foundation

enum SignInError: String,Error {
    case badlyEmailFormatted = "The email address is badly formatted."
    case userDoesNotExist = "An internal error has occurred, print and inspect the error details for more information."
    case incorrectData
    
}
