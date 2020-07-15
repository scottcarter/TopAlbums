//
//  StubDataTaskMaker.swift
//  TopAlbumsTests
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation
@testable import TopAlbums

// Adding suppport to init clients for testing with a custom session
// created by instancing StubAlbumDataTaskMaker
class StubDataTaskMaker: DataTaskMaker {

    static let dummyURL = URL(fileURLWithPath: "Dummy URL")

    let data: Data

    init(data: Data) {
        self.data = data
    }

    // Provide the implementation for dataTask method of DataTaskMaker protocol.
    func dataTask(
        with _: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        completionHandler(
            data,

            HTTPURLResponse(
                url: Self.dummyURL,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            ),
            nil // Error is nil - we have complete control over our stub.
        )

        // We need to return a URLSessionDataTask, but it won't hit the network
        // and thus doesn't need to be initialized with a valid URL.
        //
        // URLSessionDataTask() is deprecated
        //
        return  URLSession.shared.dataTask(with: Self.dummyURL)
    }
}
