//
//  UIImage+systemName.swift
//  MoviesApp
//
//  Created by 1 on 23.11.2023.
//

import UIKit

extension UIImage {
    static var heartImage: UIImage {
        UIImage(systemName: "heart")!
    }
    
    static var heartFillImage: UIImage {
        UIImage(systemName: "heart.fill")!
    }
    
    static var shareImage: UIImage {
        UIImage(systemName: "square.and.arrow.up")!
    }
    
    static var signOut: UIImage {
        UIImage(systemName: "rectangle.portrait.and.arrow.forward")!
    }
    
    static var moviesTabImage: UIImage {
        UIImage(systemName: "list.and.film")!
    }
    
    static var favoriteMoviesTabImage: UIImage {
        UIImage(systemName: "star")!
    }
    
    static var userProfileTabImage: UIImage {
        UIImage(systemName: "person")!
    }
}
