//
//  AlbumClientTests.swift
//  TopAlbumsTests
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import XCTest
@testable import TopAlbums

class AlbumClientTests: XCTestCase {

    let timeout: TimeInterval = 3
    var expectation: XCTestExpectation!

    // This gets executed at the start of each test method.
    override func setUp() {
        expectation = expectation(description: "Server responds in reasonable time")
    }

    // Fetch JSON over the network and decode successfully
    func test_serverDecodeAlbumFeed() throws {

        let url = try XCTUnwrap(Constants.AlbumFeed.feedURL)

        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill() }

            XCTAssertNil(error)

            do {
                let response = try XCTUnwrap(response as? HTTPURLResponse)
                XCTAssertEqual(response.statusCode, 200)

                let data = try XCTUnwrap(data)
                XCTAssertNoThrow(
                    try JSONDecoder().decode(AlbumFeed.self, from: data)
                )
            } catch { }
        }
        .resume()

        waitForExpectations(timeout: timeout)
    }

    // Fetch JSON over the network and test a failing decode.
    func test_serverInvalidDecodeAlbumFeed() throws {

        let url = try XCTUnwrap(Constants.AlbumFeed.feedURL)

        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill() }

            XCTAssertNil(error)

            // Just checking status code, so we won't bother to unwrap
            XCTAssertEqual( (response as? HTTPURLResponse)?.statusCode, 200)

            do {
                _ = try JSONDecoder().decode(
                    InvalidAlbumFeed.self,
                    from: try XCTUnwrap(data)
                )
            } catch {
                switch error {
                case DecodingError.keyNotFound(let key, _):
                    XCTAssertEqual(key.stringValue, InvalidAlbumFeed.invalidField)
                default:
                    XCTFail("\(error)")
                }
            }
        }
        .resume()

        waitForExpectations(timeout: timeout)
    }

    // Test the AlbumClient with stubbed data
    func test_AlbumClient() throws {

        _ = AlbumClient(
            albumFeedURL: StubAlbumDataTaskMaker.dummyURL,
            session: try StubAlbumDataTaskMaker(),
            responseQueue: nil
        ).getAlbumFeed { albumFeed, error in
            defer { self.expectation.fulfill() }

            XCTAssertEqual(albumFeed?.feed.albums.count, StubAlbumDataTaskMaker.expectedResultCount)
            XCTAssertNil(error)
        }

        // Since we are not going over the network, we don't need a timeout.
        waitForExpectations(timeout: 0)
    }
}
