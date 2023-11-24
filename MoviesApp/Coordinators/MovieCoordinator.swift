//
//  MovieCoordinator.swift
//  MoviesApp
//
//  Created by 1 on 20.11.2023.
//

import UIKit

class MovieCoordinator: Coordinator {
    var rootViewController: UIViewController {
        navigationController
    }
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController =  navigationController
    }
    
    func start() {
        openMovieListScreen()
    }
    
    private func openMovieListScreen() {
        let movieLoader = ITunesMovieLoader()
        let model = [Movie]()
        let store = FavoriteMoviesFireBaseStore()
        let movieImageLoader = MovieImageLoader()
        let movieListViewController = MovieListViewController(model: model,
                                                              movieLoader: movieLoader,
                                                              store: store,
                                                              movieImageLoader: movieImageLoader)
        movieListViewController.onSelectMovie = openMovieDetailsScreen(movie:)
        navigationController.viewControllers = [movieListViewController]
    }
    
    private func openMovieDetailsScreen(movie: Movie) {
        let movieImageLoader = MovieImageLoader()
        let movieDetailsViewController = MovieDetailsViewController(movie: movie, movieImageLoader: movieImageLoader)
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}

