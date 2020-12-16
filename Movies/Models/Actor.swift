//
//  Actor.swift
//  Movies
//
//  Created by Smith Huamani Hilario on 12/3/20.
//

import UIKit

struct Actor: Codable {
    
    var id: Int
    var cast: [Cast]

    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
    }
    
}

struct Cast: Codable {
    
    var order: Int
    var name: String
    var profilePath: String?

    public enum CodingKeys: String, CodingKey {
        case order = "order"
        case name = "name"
        case profilePath = "profile_path"
    }
    
}
