//
//  ImageClient.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation
import UIKit

class ImageClient {

    // MARK: - Constants

    private let responseQueue: DispatchQueue?
    private let session: DataTaskMaker

    static let shared =
        ImageClient(
            session: URLSession.shared,
            responseQueue: .main
    )

    // MARK: - Initializers

    init(
        session: DataTaskMaker,
        responseQueue: DispatchQueue?
    ) {

        self.responseQueue = responseQueue
        self.session = session
    }

    // MARK: - Functions

    func setImage(on imageView: UIImageView,
                  fromURL url: URL,
                  withPlaceholder placeholder: UIImage?,
                  completion: @escaping (UIImage?, Error?) -> Void
    ) {

        imageView.image = placeholder

        _ = downloadImage(fromURL: url) { image, error  in

                if error != nil {
                    completion(nil, error)
                    return
                }

                guard let image = image else {
                    return
                }
                imageView.image = image
                completion(image, nil)
        }
    }

}

private extension ImageClient {

    func downloadImage(
        fromURL url: URL,
        completion: @escaping (UIImage?, Error?) -> Void
    ) -> URLSessionDataTask? {

        let dataTask =
            session.dataTask(with: url) { [weak self] data, response, error in

                guard let self = self else { return }

                guard let response = response as? HTTPURLResponse,
                    (200..<300).contains(response.statusCode),
                    error == nil,
                    let data = data,
                    let image = UIImage(data: data) else {
                        self.dispatchResult(error: error, completion: completion)
                        return
                }

                self.dispatchResult(image: image, completion: completion)
        }
        dataTask.resume()
        return dataTask
    }

    func dispatchResult(
        image: UIImage? = nil,
        error: Error? = nil,
        completion: @escaping (UIImage?, Error?) -> Void) {

        guard let responseQueue = responseQueue else {
            completion(image, error)
            return
        }
        responseQueue.async {
            completion(image, error)
        }
    }

}
