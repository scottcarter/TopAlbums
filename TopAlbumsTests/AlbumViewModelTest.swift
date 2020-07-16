//
//  AlbumViewModelTest.swift
//  TopAlbumsTests
//
//  Created by Scott Carter on 7/16/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import XCTest
@testable import TopAlbums

class AlbumViewModelTest: XCTestCase {

    func testAlbum() throws {

        let albumClient = try AlbumUtilities.albumClient()

        // Load test copy of albums directly using AlbumClient
        let albums = AlbumUtilities.getAlbums(using: albumClient)

        // Get our first album
        let album = try(XCTUnwrap(albums.first))

        let albumView = AlbumView()
        let albumViewModel = AlbumViewModel(album: album)

        // Expect view check to fail before configuration
        try checkView(using: albumView, album: album, expectingPass: false)

        albumViewModel.configure(albumView)

        try checkView(using: albumView, album: album, expectingPass: true)
    }

    func checkView(
        using albumView: AlbumView,
        album testAlbum: Album,
        expectingPass: Bool
    ) throws {

        let firstGenre = try XCTUnwrap(testAlbum.genres.first)

        // Check album name, artist name, genre, copyright.
        // Not currently checking release date which is formatted.
        if expectingPass {
            XCTAssertEqual(albumView.albumName.text, testAlbum.name)
            XCTAssertEqual(albumView.artistName.text, testAlbum.artistName)
            XCTAssertEqual(albumView.genre.text, firstGenre.name)
            XCTAssertEqual(albumView.copyright.text, testAlbum.copyright)
        } else {
            XCTAssertNotEqual(albumView.albumName.text, testAlbum.name)
            XCTAssertNotEqual(albumView.artistName.text, testAlbum.artistName)
            XCTAssertNotEqual(albumView.genre.text, firstGenre.name)
            XCTAssertNotEqual(albumView.copyright.text, testAlbum.copyright)
        }
    }

}
