//
//  ImageClient.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/13/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation
import UIKit

class ImageClient: NetworkingClient {

    // MARK: - Constants

    static let shared =
        ImageClient(
            session: URLSession.shared,
            responseQueue: .main
    )

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

                self.dispatchResult(result: image, completion: completion)
        }
        dataTask.resume()
        return dataTask
    }

}
