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

    }

}
