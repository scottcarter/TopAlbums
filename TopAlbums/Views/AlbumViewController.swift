//
//  AlbumViewController.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/14/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {

    // MARK: - Variable Properties

    var album: Album?

    // MARK: - Lifecycle

    override func loadView() {
        let albumView = AlbumView()
        let albumViewModel = AlbumViewModel(album: album)

        albumView.albumViewModel = albumViewModel

        view = albumView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
    }

}
