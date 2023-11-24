//
//  ItunesResult.swift
//  MoviesApp
//
//  Created by 1 on 19.11.2023.
//

import Foundation

struct ItunesResult: Codable {
    let resultCount: Int
    let results: [ITunesMovie]
}

struct ITunesMovie: Codable {
    let wrapperType: String
    let kind: String
    let trackId: Int
    let artistName: String
    let trackName: String
    let trackCensoredName: String?
    let trackViewUrl: URL?
    let previewUrl: URL?
    let artworkUrl100: URL
    let releaseDate: String
    let primaryGenreName: String
    let longDescription: String?
}

