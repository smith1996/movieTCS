//
//  MovieResponse.swift
//  Movies
//
//  Created by Smith Huamani Hilario on 12/2/20.
//

import UIKit
    
struct Results: Codable {
    var results: [Movie]
    
    public enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct Movie: Codable {
    
    var id: Int
    var overview: String
    var releaseDate: String
    var voteCount: Int
    var popularity: Double
    var voteAverage: Double
    var posterPath: String
    var originalTitle: String
    var title: String
    var backdropPath: String

    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case overview = "overview"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case popularity = "popularity"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case title = "title"
        case backdropPath = "backdrop_path"
    }
    
}

