//
//  InvalidAlbumFeed.swift
//  TopAlbumsTests
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation
@testable import TopAlbums

// Create a test struct that contains a field not present in JSON,
struct InvalidAlbumFeed: Decodable {
    let feed: Feed
    let invalidField: String

    static let invalidField = "invalidField"
}
