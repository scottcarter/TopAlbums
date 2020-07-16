//
//  AlbumsViewModel.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/14/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation
import UIKit

class AlbumsViewModel {

    // MARK: - Variable Properties

    private var albums = [Album]()

    // MARK: - Functions

    func album(for index: Int) -> Album? {
        albums.count > index ? albums[index] : nil
    }

    func configure(
        _ cell: AlbumsTableViewCell,
        for index: Int,
        with imageClient: ImageClient
    ) {

        guard let album = album(for: index) else {
            return
        }

        cell.albumName.text = album.name
        cell.albumName.font = UIFont.systemFont(ofSize: 20.0)

        cell.artistName.text = album.artistName
        cell.artistName.font = UIFont.systemFont(ofSize: 14.0)

        guard let thumbnailURL = URL(string: album.artworkURL) else {
            return
        }

        imageClient.setImage(
            on: cell.albumArt,
            fromURL: thumbnailURL,
            withPlaceholder: UIImage(systemName: "photo"),
            completion: { _, _  in }
        )
     }

    func loadAlbums(
        with albumClient: AlbumClient,
        completion: @escaping () -> Void
    ) {
        _ = albumClient.getAlbumFeed { [weak self] albumFeed, error in

            guard let self = self else { return }

            // No requirement to visually handle errors, but alert the developer
            // in Debug config.
            if let error = error {
                assertionFailure("Unable to get album feed: \(error.localizedDescription)")
                return
            }

            guard let albumFeed = albumFeed else {
                assertionFailure("Unexpected nil album feed without an error.")
                return
            }

            self.albums = albumFeed.feed.albums

            completion()
        }

    }

    // MARK: - Computed Properties

    var albumCount: Int {
        return albums.count
    }

}
