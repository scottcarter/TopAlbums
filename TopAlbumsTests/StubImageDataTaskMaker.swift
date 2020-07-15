//
//  StubImageDataTaskMaker.swift
//  TopAlbumsTests
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation
import XCTest

// Customize data property of StubDataTaskMaker with init override
// for testing ImageClient.
class StubImageDataTaskMaker: StubDataTaskMaker {

    override init(data: Data) {
        super.init(data: data)
    }

    convenience init() throws {
        let data = try Self.imageData()

        self.init(data: data)
    }

    static func imageData() throws -> Data {
        let testBundle = Bundle(for: Self.self)
        let url = try XCTUnwrap(
            testBundle.url(forResource: "thumbnail", withExtension: "png")
        )
        let data = try Data(contentsOf: url)
        return data
    }
}
