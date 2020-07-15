//
//  AlbumViewModel.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/14/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import Foundation
import UIKit

class AlbumViewModel {

    // MARK: - Functions

    func configure(_ view: AlbumView, using album: Album?) {

        guard let album = album else {
            return
        }

        view.albumName.text = album.name
        view.albumName.font = UIFont.systemFont(ofSize: 20.0)
        view.albumName.numberOfLines = 2
        view.albumName.textAlignment = .center

        view.artistName.text = album.artistName
        view.artistName.font = UIFont.systemFont(ofSize: 14.0)

        // There can be multiple genres entries. The first is what we want.
        if let albumGenre = album.genres.first?.name {
            view.genre.text = albumGenre
        }
        view.genre.font = UIFont.systemFont(ofSize: 14.0)

        // FIXME - format date
        view.releaseDate.text = album.releaseDate
        view.releaseDate.font = UIFont.systemFont(ofSize: 14.0)

        view.copyright.text = album.copyright
        view.copyright.font = UIFont.systemFont(ofSize: 14.0)

        // We need a reasonable limit on number of lines for copyright to avoid
        // overlap with bottom button on small devices.  There are alternatives
        // such as allowing the font to scale.
        view.copyright.numberOfLines = 4

        guard let artworkURL = URL(string: album.artworkURL) else {
            return
        }

        ImageClient.shared.setImage(
            on: view.albumArt,
            fromURL: artworkURL,
            withPlaceholder: UIImage(systemName: "photo"),
            completion: { _, _  in }
        )

        // Store button
        view.storeButton.setTitle("Visit in iTunes Store", for: .normal)
        view.storeButton.setTitleColor(.systemBlue, for: .normal)
        view.storeButton.addTarget(self, action: #selector(storeButtonAction(sender:)), for: .touchUpInside)
    }

    @objc func storeButtonAction(sender: AnyObject) {
        print("Clicked") // FIXME itunes button
    }

}
