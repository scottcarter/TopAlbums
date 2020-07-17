//
//  AlbumClient.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation

class AlbumClient: NetworkingClient {

    // MARK: - Constants

    private let albumFeedURL: URL?

    static let shared =
        AlbumClient(
            albumFeedURL: Constants.AlbumFeed.feedURL,
            session: URLSession.shared,
            responseQueue: .main
    )

    // MARK: - Initializers

    init(
        albumFeedURL: URL?,
        session: DataTaskMaker,
        responseQueue: DispatchQueue?
    ) {
        self.albumFeedURL = albumFeedURL

        super.init(session: session, responseQueue: responseQueue)
    }

    // MARK: - Functions

    func getAlbumFeed(
        completion: @escaping (AlbumFeed?, Error?) -> Void
    ) -> URLSessionDataTask? {

        guard let albumFeedURL = albumFeedURL else {
            return nil
        }

        let task =
            session.dataTask(with: albumFeedURL) { [weak self] data, response, error in

                guard let self = self else { return }

                guard let response = response as? HTTPURLResponse,
                    (200..<300).contains(response.statusCode),
                    error == nil,
                    let data = data else {
                        self.dispatchResult(error: error, completion: completion)
                        return
                }

                let decoder = JSONDecoder()
                do {
                    let feed = try decoder.decode(AlbumFeed.self, from: data)
                    self.dispatchResult(result: feed, completion: completion)
                } catch {
                    self.dispatchResult(error: error, completion: completion)
                }
        }
        task.resume()
        return task
    }
}
