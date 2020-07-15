//
//  StubAlbumDataTaskMaker.swift
//  TopAlbumsTests
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation
import XCTest

// Customize data property of StubDataTaskMaker with init override
// for testing AlbumClient.
class StubAlbumDataTaskMaker: StubDataTaskMaker {

    static let expectedResultCount = 10 // For albumFeed.json

    override init(data: Data) {
        super.init(data: data)
    }

    convenience init() throws {
        let testBundle = Bundle(for: Self.self)
        let url = try XCTUnwrap(
            testBundle.url(forResource: "albumFeed", withExtension: "json")
        )
        let data = try Data(contentsOf: url)

        self.init(data: data)
    }
}
