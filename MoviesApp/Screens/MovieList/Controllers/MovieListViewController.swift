//
//  MovieListViewController.swift
//  MoviesApp
//
//  Created by 1 on 17.11.2023.
//

import UIKit
import Combine

class MovieListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var onSelectMovie: ((Movie) -> Void)?

    private var model: [Movie]
    private let store: FavoriteMoviesFireBaseStore
    private let movieLoader: ITunesMovieLoader
    private let movieImageLoader: MovieImageLoader
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(model: [Movie],
         movieLoader: ITunesMovieLoader,
         store: FavoriteMoviesFireBaseStore,
         movieImageLoader: MovieImageLoader) {
        self.model = model
        self.movieLoader = movieLoader
        self.store = store
        self.movieImageLoader = movieImageLoader
        super.init(nibName: MovieListViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @Published private var searchBarText: String = ""
    
    private var cancelabble = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        tableView.register(MovieCell.self)
        
        loadMovies(term: "romance")
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        
        $searchBarText
            .filter { text in !text.isEmpty}
            .debounce(for: .seconds(2), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.loadMovies(term: text)
                print(text)
            }.store(in: &cancelabble)
        
        setupRefreshControl()
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.addTarget(self,
                                 action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func didPullToRefresh(_ sender: UIRefreshControl) {
        if !searchBarText.isEmpty {
            loadMovies(term: searchBarText)
        }
        
        sender.endRefreshing()
    }
    
    private func loadMovies(term: String) {
        movieLoader.load(term: term) { [weak self] result in
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
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        searchBarText = searchText
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onSelectMovie?(model[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

extension MovieListViewController: UITableViewDataSource {
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
            self?.store.add(movie: currentMovie)
        }
        
        return cell
    }
}
