//
//  AlbumTableViewCell.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/14/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    // MARK: - Constants

    let albumArt = UIImageView()
    let albumName = UILabel()
    let artistName = UILabel()

    // MARK: - Lifecycle

    // Prevent table row for highlighting during selection.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

private extension AlbumsTableViewCell {

    func addSubviews() {
        // Fill the available space and clip as needed
        // We are dealing with square images, so not strictly necessary.
        albumArt.contentMode = .scaleAspectFill
        albumArt.clipsToBounds = true

        let labelStackView = UIStackView(arrangedSubviews: [albumName, artistName])
        labelStackView.axis = .vertical
        labelStackView.alignment = .leading
        labelStackView.spacing = 10.0

        // We are defaulting to fill distribution for rowStackView.
        // Lower the content hugging priority of label stack view so that it can grow
        // inside rowStackView. The albumArt UIImageView will use instrinsic size.
        labelStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        let rowStackView = UIStackView(arrangedSubviews: [albumArt, labelStackView])
        rowStackView.alignment = .center
        rowStackView.spacing = 10.0

        contentView.addSubview(rowStackView)

        // Add constraints

        rowStackView.translatesAutoresizingMaskIntoConstraints = false

        albumArt.heightAnchor.constraint(equalToConstant: Constants.AlbumsTable.albumArtHeight).isActive = true
        albumArt.widthAnchor.constraint(equalTo: albumArt.heightAnchor).isActive = true

        rowStackView.leadingAnchor.constraint(
            equalTo: self.contentView.leadingAnchor,
            constant: 40.0
        ).isActive = true

        rowStackView.topAnchor.constraint(
            equalTo: self.contentView.topAnchor,
            constant: 0.0
        ).isActive = true

        rowStackView.trailingAnchor.constraint(
            equalTo: self.contentView.trailingAnchor,
            constant: -40.0
        ).isActive = true

        rowStackView.bottomAnchor.constraint(
            equalTo: self.contentView.bottomAnchor,
            constant: 0.0
        ).isActive = true

    }

}
