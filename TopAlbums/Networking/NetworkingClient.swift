//
//  NetworkingClient.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/17/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation

class NetworkingClient {

    // MARK: - Constants

    let responseQueue: DispatchQueue?
    let session: DataTaskMaker

    // MARK: - Initializers

    init(
        session: DataTaskMaker,
        responseQueue: DispatchQueue?
    ) {

        self.responseQueue = responseQueue
        self.session = session
    }

     // MARK: - Functions

    func dispatchResult<Type>(
        result: Type? = nil,
        error: Error? = nil,
        completion: @escaping (Type?, Error?) -> Void
    ) {
        guard let responseQueue = responseQueue else {
            completion(result, error)
            return
        }
        responseQueue.async {
            completion(result, error)
        }
    }
}
