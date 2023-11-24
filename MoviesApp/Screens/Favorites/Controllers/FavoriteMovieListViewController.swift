//
//  FavoriteMovieListViewController.swift
//  MoviesApp
//
//  Created by 1 on 17.11.2023.
//

import UIKit

class FavoriteMovieListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var onSelectMovie: ((Movie) -> Void)?
    
    private var model: [Movie]
    private let store: FavoriteMoviesFireBaseStore
    private let userFavoriteMoviesLoader: FirebaseFavoriteMoviesLoader
    private let movieImageLoader: MovieImageLoader
    
    init(model: [Movie],
         store: FavoriteMoviesFireBaseStore,
         userFavoriteMoviesLoader: FirebaseFavoriteMoviesLoader,
         movieImageLoader: MovieImageLoader) {
        self.model = model
        self.store = store
        self.userFavoriteMoviesLoader = userFavoriteMoviesLoader
        self.movieImageLoader = movieImageLoader
        super.init(nibName: FavoriteMovieListViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        tableView.register(MovieCell.self)
        setupRefreshControl()
        loadFavoriteMovies()
    }
    
    private func loadFavoriteMovies() {
        userFavoriteMoviesLoader.load { [weak self] result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.model = movies
                    self?.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }

    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.addTarget(self,
                                 action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func didPullToRefresh(_ sender: UIRefreshControl) {
        loadFavoriteMovies()
        sender.endRefreshing()
    }
}

extension FavoriteMovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onSelectMovie?(model[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

extension FavoriteMovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection numberOfRowsInSectionsection: Int) -> Int {
        model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let currentMovie = model[indexPath.row]
        
        cell.nameLabel.text = currentMovie.title
        
        cell.descriptionLabel.text = "\(currentMovie.genre) \(currentMovie.year)"

        if let url = URL(string: currentMovie.thumbnailImageName) {
            movieImageLoader.load(url: url) { data in
                DispatchQueue.main.async {
                    cell.thumbnailImageView.image = UIImage(data: data)
                }
            }
        }
        
        cell.setFavoriteButton(isFavorited: currentMovie.isFavorite)
        
        cell.onTapFavoriteButton = { [weak self] in
            currentMovie.isFavorite.toggle()
            
            self?.store.remove(movie: currentMovie)
            
            self?.model.remove(at: indexPath.row)
            self?.tableView.reloadData()
        }
        
        return cell
    }
}

