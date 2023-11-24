//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by 1 on 17.11.2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var movieInfoLabel: UILabel!
    @IBOutlet var movieDescriptionLabel: UILabel!
    
    private let movie: Movie
    private let movieImageLoader: MovieImageLoader
    
    init(movie: Movie, movieImageLoader: MovieImageLoader) {
        self.movie = movie
        self.movieImageLoader = movieImageLoader
        super.init(nibName: MovieDetailsViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMovieImage()
    }
    
    private func loadMovieImage() {
        let url = URL(string: movie.thumbnailImageName)!
        
        movieImageLoader.load(url: url, completionHandler: { [weak self] data in

            DispatchQueue.main.async {
                self?.movieImageView.image = UIImage(data: data)
            }
        })
    }
    
    private func setupViews() {
        nameLabel.text = movie.title
        movieInfoLabel.text = "\(movie.genre) \(movie.year)"
        movieDescriptionLabel.text = movie.description
        setupBarButtonItems()
    }
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .shareImage,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapShareButton))
    }
    
    @objc private func didTapShareButton() {
        let shareInfo = "\(movie.title) \(movie.description)"
        let activityController = UIActivityViewController(activityItems: [shareInfo], applicationActivities: nil)
        present(activityController, animated: true)
    }
}
