//
//  Constants.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation
import UIKit

enum Constants {

    enum AlbumFeed {

        // The max number of albums to fetch.  This is currently limited
        // to 51 by the server.
        static let numberOfAlbums = 100

        static var feedURL: URL? {
            let feedBase = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all"
            let feed = "\(feedBase)/\(numberOfAlbums)/explicit.json"

            return URL(string: feed)
        }

        // For testing
        static var thumbnailURL = URL(string: "https://is3-ssl.mzstatic.com/image/thumb/Music114/v4/a1/09/bc/a109bc6a-21d2-53c5-248a-be19b20ba9da/20UMGIM53351.rgb.jpg/200x200bb.png")

    }

    enum Album {
        static let albumArtHeight: CGFloat = 200.0 // The size of original
    }

    enum AlbumsTable {
        static let rowHeight: CGFloat = 100.0
        static let albumArtHeight: CGFloat = 90.0 // To allow for row separation
    }

}
