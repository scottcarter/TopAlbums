//
//  Album.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation

struct Album: Codable, Equatable {

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

    static func == (lhs: Album, rhs: Album) -> Bool {
        return
            lhs.artistName == rhs.artistName &&
            lhs.artworkURL == rhs.artworkURL &&
            lhs.copyright == rhs.copyright &&
            lhs.genres == rhs.genres &&
            lhs.name == rhs.name &&
            lhs.releaseDate == rhs.releaseDate &&
            lhs.albumURL == rhs.albumURL
    }

}
