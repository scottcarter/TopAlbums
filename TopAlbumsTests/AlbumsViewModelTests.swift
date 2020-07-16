//
//  AlbumsViewModelTests.swift
//  TopAlbumsTests
//
//  Created by Scott Carter on 7/15/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import XCTest
@testable import TopAlbums

class AlbumsViewModelTests: XCTestCase {

    func testAlbums() throws {

        let albumsViewModel = AlbumsViewModel()

        let albumClient = try AlbumUtilities.albumClient()

        // Load test copy of albums directly using AlbumClient
        let albums = AlbumUtilities.getAlbums(using: albumClient)

        // Get our first album
        let album = try(XCTUnwrap(albums.first))

        // Expect cell configuration check to fail since we haven't loaded
        // albums into view model.
        try checkCellConfiguration(using: albumsViewModel, album: album, expectingPass: false)

        // Load albums into view model and check view model's albumCount variable
        albumsViewModel.loadAlbums(with: albumClient) {
            XCTAssertEqual(albumsViewModel.albumCount, StubAlbumDataTaskMaker.expectedResultCount)
        }

        // Retrieve first album using view model method and then
        // compare our album to view model version
        let viewModelAlbum = try XCTUnwrap(albumsViewModel.album(for: 0))
        XCTAssertEqual(viewModelAlbum, album)

        // Check the view model configure method.  It should succeed since
        // the view model has loaded albums.
        try checkCellConfiguration(using: albumsViewModel, album: album, expectingPass: true)
    }

    func checkCellConfiguration(
        using albumsViewModel: AlbumsViewModel,
        album testAlbum: Album,
        expectingPass: Bool
    ) throws {
        let tableViewCell = AlbumsTableViewCell()

        let imageClient =
            ImageClient(
                session: try StubImageDataTaskMaker(),
                responseQueue: nil
        )

        // Check cell configuration for first album
        albumsViewModel.configure(tableViewCell, for: 0, with: imageClient)

        // Check album name, artist name
        // Not currently checking albumArt (UIImageView)
        if expectingPass {
            XCTAssertEqual(tableViewCell.albumName.text, testAlbum.name)
            XCTAssertEqual(tableViewCell.artistName.text, testAlbum.artistName)
        } else {
            XCTAssertNotEqual(tableViewCell.albumName.text, testAlbum.name)
            XCTAssertNotEqual(tableViewCell.artistName.text, testAlbum.artistName)
        }
    }

}
