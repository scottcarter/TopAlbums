//
//  DataTaskMaker.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation

protocol DataTaskMaker {
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

// Make URLSession conform to DataTaskMaker, so that we can
// use the latter as our session type with calls to dataTask().
// For testing we take advantage of our ability to conform a test struct
// to DataTaskMaker and implement a custom dataTask method without
// involving network calls.
extension URLSession: DataTaskMaker { }
