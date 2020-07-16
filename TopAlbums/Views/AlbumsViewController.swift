//
//  AlbumsViewController.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/13/20.
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

        // Need this since we constrain table view to safe area on bottom
        // and this color will display.
        view.backgroundColor = .systemBackground

        loadViews()

        albumsViewModel?.loadAlbums(with: AlbumClient.shared) { [weak self] in
            self?.tableView.reloadData()
        }
    }

}

private extension AlbumsViewController {

    func loadViews() {
        tableView.register(AlbumsTableViewCell.classForCoder(), forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedRowHeight = Constants.AlbumsTable.rowHeight

        view.addSubview(tableView)

        addTableViewContraints()
    }

    func addTableViewContraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor,
            constant: 0.0
        ).isActive = true

        tableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: 0.0
        ).isActive = true

        tableView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: 0.0
        ).isActive = true

        // We will allow scroll behind navigation bar - not
        // constraining to safe area.
        tableView.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 0.0
        ).isActive = true

    }

}

// MARK: UITableViewDelegate
extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
            tableView.dequeueReusableCell(
                withIdentifier: cellReuseIdentifier,
                for: indexPath
                ) as? AlbumsTableViewCell else {
                    assertionFailure("Can't dequeue AlbumTableViewCell")
                    return AlbumsTableViewCell()
        }

        albumsViewModel?.configure(cell, for: indexPath.row, with: ImageClient.shared)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.AlbumsTable.rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumViewController = AlbumViewController()
        albumViewController.album = albumsViewModel?.album(for: indexPath.row)
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
