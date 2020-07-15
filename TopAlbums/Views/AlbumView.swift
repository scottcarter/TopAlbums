//
//  AlbumView.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/14/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import UIKit

class AlbumView: UIView {

    // MARK: - Constants

    let albumArt = UIImageView()
    let albumName = UILabel()
    let artistName = UILabel()
    let genre = UILabel()
    let releaseDate = UILabel()
    let copyright = UILabel()

    let storeButton = UIButton()

    // MARK: - Variable Properties

    var albumViewModel: AlbumViewModel?
    var viewIsConfigured = false

    // MARK: - Lifecycle

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        if !viewIsConfigured {
            viewIsConfigured = true

            self.backgroundColor = .systemBackground
            addSubviews()
            albumViewModel?.configure(self)
        }
    }

    // Respond to trait collection changes
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            albumViewModel?.updateStoreButtonBorder(self)
        }
    }

}

private extension AlbumView {

    func addSubviews() {
        // Fill the available space and clip as needed
        // We are dealing with square images, so not strictly necessary.
        albumArt.contentMode = .scaleAspectFill
        albumArt.clipsToBounds = true

        let headerStackView = UIStackView(arrangedSubviews: [albumName, artistName])
        headerStackView.axis = .vertical
        headerStackView.distribution = .fillProportionally
        headerStackView.alignment = .center
        headerStackView.spacing = 10.0

        let footerStackView = UIStackView(arrangedSubviews: [genre, releaseDate, copyright])
        footerStackView.axis = .vertical
        footerStackView.distribution = .fillProportionally
        footerStackView.alignment = .center
        footerStackView.spacing = 10.0

        let mainStackView = UIStackView(arrangedSubviews: [headerStackView, albumArt, footerStackView])
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 10.0

        self.addSubview(mainStackView)
        self.addSubview(storeButton)

        // Add constraints
        albumArt.heightAnchor.constraint(equalToConstant: Constants.Album.albumArtHeight).isActive = true
        albumArt.widthAnchor.constraint(equalTo: albumArt.heightAnchor).isActive = true

        constrainMainStackView(mainStackView)
        constrainStoreButton()
    }

    func constrainMainStackView(_ mainStackView: UIStackView) {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        mainStackView.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor,
            constant: 40.0
        ).isActive = true

        mainStackView.topAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.topAnchor,
            constant: 10.0
        ).isActive = true

        mainStackView.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor,
            constant: -40.0
        ).isActive = true
    }

    func constrainStoreButton() {
        storeButton.translatesAutoresizingMaskIntoConstraints = false

        storeButton.leadingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.leadingAnchor,
            constant: 20.0
        ).isActive = true

        storeButton.bottomAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.bottomAnchor,
            constant: -20.0
        ).isActive = true

        storeButton.trailingAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.trailingAnchor,
            constant: -20.0
        ).isActive = true

        storeButton.centerXAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.centerXAnchor
        ).isActive = true
    }
}
