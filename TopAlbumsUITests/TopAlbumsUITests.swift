//
//  TopAlbumsUITests.swift
//  TopAlbumsUITests
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import XCTest

// We need access to Constants.swift, but a UI test cannot access it
// with an import of TopAlbums.  Instead we include Constants.swift in the
// target membership of TopAlbumsUITests.

class TopAlbumsUITests: XCTestCase {

    var app: XCUIApplication?

    override func setUpWithError() throws {
        app = XCUIApplication()
        app?.launch()
        continueAfterFailure = false
    }

    func testNavigation() throws {

        let app = try XCTUnwrap(self.app)

        let tableNavBar = app.navigationBars["Top Albums"]
        let albumPageNavBar = app.navigationBars["TopAlbums.AlbumView"]

        // Start on table view
        XCTAssertTrue(tableNavBar.exists)
        XCTAssertFalse(albumPageNavBar.exists)

        // Record the album and artist name from the first cell.
        // If there are no cells, the test will fail when we attempt to
        // record first label.
        let tablesQuery = app.tables
        let cellQuery = tablesQuery.cells.matching(identifier: "0")
        let cellElement = cellQuery.element

        let cellAlbumName = tablesQuery
            .staticTexts
            .matching(identifier: Constants.AlbumsTable.albumNameIdentifier)
            .firstMatch
            .label

        let cellArtistName = tablesQuery
            .staticTexts
            .matching(identifier: Constants.AlbumsTable.artistNameIdentifier)
            .firstMatch
            .label

        // Tap first cell to visit album page.
        cellElement.tap()

        XCTAssertFalse(tableNavBar.exists)
        XCTAssertTrue(albumPageNavBar.exists)

        // Check album and artist name against what was recorded for table cell.
        XCTAssertEqual(
            app
                .staticTexts
                .matching(identifier: Constants.Album.albumNameIdentifier)
                .firstMatch
                .label,
            cellAlbumName)

        XCTAssertEqual(
            app
                .staticTexts
                .matching(identifier: Constants.Album.artistNameIdentifier)
                .firstMatch
                .label,
            cellArtistName)

        // Tap button to go back to table view
        albumPageNavBar.buttons["Top Albums"].tap()

        // Finish on table view
        XCTAssertTrue(tableNavBar.exists)
        XCTAssertFalse(albumPageNavBar.exists)

    }

}
