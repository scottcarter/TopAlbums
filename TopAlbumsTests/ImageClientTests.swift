//
//  ImageClientTests.swift
//  TopAlbumsTests
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import XCTest
@testable import TopAlbums

class ImageClientTests: XCTestCase {

    let timeout: TimeInterval = 3
    var expectation: XCTestExpectation!

    // This gets executed at the start of each test method.
    override func setUp() {
        expectation = expectation(description: "Server responds in reasonable time")
    }

    // Fetch JSON over the network and decode successfully
    func test_serverImage() throws {

        let url = try XCTUnwrap(Constants.AlbumFeed.thumbnailURL)

        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill() }

            XCTAssertNil(error)

            do {
                let response = try XCTUnwrap(response as? HTTPURLResponse)
                XCTAssertEqual(response.statusCode, 200)

                let data = try XCTUnwrap(data)

                // Make sure we can initialize an image from datas
                _ = try XCTUnwrap(UIImage(data: data))

            } catch { }
        }
        .resume()

        waitForExpectations(timeout: timeout)
    }

    // Test the ImageClient with stubbed data
    func test_ImageClient() throws {

        let imageView = UIImageView()

        ImageClient(
            session: try StubImageDataTaskMaker(),
            responseQueue: nil
        ).setImage(
            on: imageView,
            fromURL: StubImageDataTaskMaker.dummyURL,
            withPlaceholder: nil
        ) { image, error in

            defer { self.expectation.fulfill() }

            XCTAssertNil(error)

            do {
                // image should not be nil
                let image = try XCTUnwrap(image)

                // Did the imageView image get set with the image returned in closure?
                XCTAssertEqual(imageView.image, image)

                // Does the image match what we stubbed?
                let stubImageData = try StubImageDataTaskMaker.imageData()
                let stubImage = try XCTUnwrap(UIImage(data: stubImageData))

                let stubImagePngData = try XCTUnwrap(stubImage.pngData()) as NSData
                let imagePngData = try XCTUnwrap(image.pngData()) as NSData

                XCTAssertTrue(stubImagePngData.isEqual(imagePngData))
            } catch {
                XCTFail("\(error)")
            }

        }

        // Since we are not going over the network, we don't need a timeout.
        waitForExpectations(timeout: 0)
    }

}
