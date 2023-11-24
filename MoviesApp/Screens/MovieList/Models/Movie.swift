//
//  Movie.swift
//  MoviesApp
//
//  Created by 1 on 17.11.2023.
//

import Foundation

class Movie {
    let id: String
    let thumbnailImageName: String
    let title: String
    let year: Int
    let genre: String
    var isFavorite: Bool
    let description: String
    
    init(id: String, thumbnailImageName: String, title: String, year: Int, genre: String, isFavorite: Bool, description: String) {
        self.id = id
        self.thumbnailImageName = thumbnailImageName
        self.title = title
        self.year = year
        self.genre = genre
        self.isFavorite = isFavorite
        self.description = description
    }
}
