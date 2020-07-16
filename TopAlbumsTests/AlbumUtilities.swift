//
//  AlbumUtilities.swift
//  TopAlbumsTests
//
//  Created by Scott Carter on 7/16/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import XCTest
@testable import TopAlbums

class AlbumUtilities {

    static func albumClient() throws -> AlbumClient {
        return AlbumClient(
            albumFeedURL: StubAlbumDataTaskMaker.dummyURL,
            session: try StubAlbumDataTaskMaker(),
            responseQueue: nil
        )
    }

    static func getAlbums(using albumClient: AlbumClient) -> [Album] {

        var albums = [Album]()

        _ = albumClient.getAlbumFeed { albumFeed, error in
            XCTAssertNil(error)

            do {
                let albumFeed = try XCTUnwrap(albumFeed)
                albums = albumFeed.feed.albums
            } catch {}

            XCTAssertEqual(albums.count, StubAlbumDataTaskMaker.expectedResultCount)
        }

        return albums
    }

}
