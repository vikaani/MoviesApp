//
//  MovieImageLoader.swift
//  MoviesApp
//
//  Created by 1 on 22.11.2023.
//

import Foundation

class MovieImageLoader {
    func load(url: URL, completionHandler: @escaping (Data) -> Void) {
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let result = data  else { return }
            completionHandler(result)
        }.resume()
    }
}
