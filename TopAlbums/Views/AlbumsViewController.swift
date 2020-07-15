//
//  AlbumsViewController.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/15/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {

        // MARK: - Constants

        let cellReuseIdentifier = "AlbumCell"
        let tableView = UITableView()

        // MARK: - Variable Properties

        var albumsViewModel: AlbumsViewModel?

        // MARK: - Lifecycle

        override func viewDidLoad() {
            super.viewDidLoad()

            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.title = "Top Albums"

            loadViews()

            albumsViewModel?.loadAlbums { [weak self] in
                self?.tableView.reloadData()
            }
        }

        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()

            tableView.frame = view.bounds // FIXME - constraints to safe area layout guide needed
        }

    }

    private extension AlbumsViewController {

        func loadViews() {
            tableView.register(AlbumTableViewCell.classForCoder(), forCellReuseIdentifier: cellReuseIdentifier)
            tableView.delegate = self
            tableView.dataSource = self

            tableView.estimatedRowHeight = Constants.AlbumsTable.rowHeight

            view.addSubview(tableView)
        }

    }

    // MARK: UITableViewDelegate
    extension AlbumsViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdentifier,
                    for: indexPath
                    ) as? AlbumTableViewCell else {
                        assertionFailure("Can't dequeue AlbumTableViewCell")
                        return AlbumTableViewCell()
            }

            albumsViewModel?.configure(cell, for: indexPath)

            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return Constants.AlbumsTable.rowHeight
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let albumViewController = AlbumViewController()
            albumViewController.album = albumsViewModel?.album(for: indexPath)
            navigationController?.pushViewController(albumViewController, animated: true)
        }
    }

    // MARK: UITableViewDataSource
    extension AlbumsViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return albumsViewModel?.albumCount ?? 0
        }

        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    }

