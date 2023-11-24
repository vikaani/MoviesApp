//
//  FavoritesMovieCoordinator.swift
//  MoviesApp
//
//  Created by 1 on 20.11.2023.
//

import UIKit

class FavoriteMoviesCoordinator: Coordinator {
    var rootViewController: UIViewController {
        navigationController
    }
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController =  navigationController
    }
    
    func start() {
        openFavoritesScreen()
    }
    
    private func openFavoritesScreen() {
        let store = FavoriteMoviesFireBaseStore()
        let userFavoriteMoviesLoader = FirebaseFavoriteMoviesLoader()
        let movieImageLoader = MovieImageLoader()

        let favoritesViewController = FavoriteMovieListViewController(model: [],
                                                                      store: store,
                                                                      userFavoriteMoviesLoader: userFavoriteMoviesLoader,
                                                                      movieImageLoader: movieImageLoader)
        favoritesViewController.onSelectMovie = openMovieDetailsScreen(movie:)
        navigationController.pushViewController(favoritesViewController, animated: true)
    }
    
    private func openMovieDetailsScreen(movie: Movie) {
        let movieImageLoader = MovieImageLoader()
        let movieDetailsViewController = MovieDetailsViewController(movie: movie, movieImageLoader: movieImageLoader)
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}
