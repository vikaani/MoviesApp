//
//  ITunesMovieLoader.swift
//  MoviesApp
//
//  Created by 1 on 23.11.2023.
//

import Foundation

class ITunesMovieLoader {
    typealias MovieResult = (Result<[Movie],Error>) -> Void
    
    func load(term: String, completionHandler: @escaping MovieResult) {
        let components = AppleiTunesSearchURLComponents<MovieMediaType>(
            term: term,
            locale: Locale(identifier: "US"),
            entity: .movie,
            attribute: .genre)
        
        guard let url = components.url else { return }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) {  data, response, error in
            
            guard let data = data else {
                completionHandler(.failure(error!))
                return }
            
            guard let itunesResult = try? JSONDecoder().decode(ItunesResult.self, from: data) else { return }
            
            let movies = itunesResult.results.map { itunesMovie in
                Movie(id: "\(itunesMovie.trackId)",
                      thumbnailImageName: itunesMovie.artworkUrl100.absoluteString,
                      title: itunesMovie.trackName,
                      year: itunesMovie.releaseDate.extractYear()!,
                      genre: itunesMovie.primaryGenreName,
                      isFavorite: false,
                      description: itunesMovie.longDescription ?? "")
            }
            
            completionHandler(.success(movies))
        }.resume()
    }
}

fileprivate extension String {
    func extractYear() -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return year
        } else {
            return nil
        }
    }
}
