//
//  AlbumViewController.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/14/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {

    // MARK: - Structs

    // MARK: - Enumerations

    // MARK: - Typealiases

    // MARK: - Constants

    // MARK: - Variable Properties

    var album: Album?

    // MARK: - Interface Builder Outlets

    // MARK: - Lifecycle

    override func loadView() {
        let albumView = AlbumView()
        albumView.album = album

        let albumViewModel = AlbumViewModel()
        albumView.albumViewModel = albumViewModel

        view = albumView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: - Initializers

    // MARK: - IBActions

    // MARK: - Functions

    // MARK: - Computed Properties

}
