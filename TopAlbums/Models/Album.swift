//
//  Album.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation

struct Album: Codable {
    let artistName: String
    let artworkURL: String
    let copyright: String
    let genres: [Genre]
    let name: String
    let releaseDate: String
    let albumURL: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case artworkURL = "artworkUrl100"
        case copyright
        case genres
        case name
        case releaseDate
        case albumURL = "url"
    }

}
