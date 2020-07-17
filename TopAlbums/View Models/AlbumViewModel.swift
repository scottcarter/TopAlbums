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

     // MARK: - Variable Properties

    let album: Album?

    // MARK: - Initializers

    init(album: Album?) {
        self.album = album
    }

    // MARK: - Functions

    func configure(_ view: AlbumView) {

        guard let album = album else {
            return
        }

        view.albumName.text = album.name
        view.albumName.font = UIFont.systemFont(ofSize: 20.0)
        view.albumName.numberOfLines = 2
        view.albumName.textAlignment = .center

        view.artistName.text = album.artistName
        view.artistName.font = UIFont.systemFont(ofSize: 14.0)

        // Add identifiers for UI Testing
        view.albumName.accessibilityIdentifier = Constants.Album.albumNameIdentifier
        view.artistName.accessibilityIdentifier = Constants.Album.artistNameIdentifier

        // There can be multiple genres entries. The first is what we want.
        if let albumGenre = album.genres.first?.name {
            view.genre.text = albumGenre
        }
        view.genre.font = UIFont.systemFont(ofSize: 14.0)

        configureReleaseDate(view, using: album)

        // Copyright
        // We need a reasonable limit on number of lines for copyright to avoid
        // overlap with bottom button on small devices.  There are alternatives
        // such as allowing the font to scale.
        view.copyright.numberOfLines = 4
        view.copyright.text = album.copyright
        view.copyright.font = UIFont.systemFont(ofSize: 14.0)

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

        updateStoreButtonBorder(view)

        view.storeButton.layer.borderWidth = 1.0
        view.storeButton.layer.cornerRadius = 5.0
        view.storeButton.addTarget(self, action: #selector(storeButtonAction(sender:)), for: .touchUpInside)
    }

    func updateStoreButtonBorder(_ view: AlbumView) {
        view.storeButton.layer.borderColor = Constants.Album.buttonBorderColor.cgColor
    }

}

private extension AlbumViewModel {

    // Format the release date presentation
    func configureReleaseDate(_ view: AlbumView, using album: Album) {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = .current

        if let date = formatter.date(from: album.releaseDate) {
            formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM d YYYY", options: 0, locale: .current)
            let releaseDate = formatter.string(from: date)
            view.releaseDate.text = releaseDate
        } else {
            view.releaseDate.text = album.releaseDate
        }

        view.releaseDate.font = UIFont.systemFont(ofSize: 14.0)
    }

    @objc func storeButtonAction(sender: AnyObject) {
        if let albumURL = album?.albumURL,
            let url = URL(string: albumURL),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
