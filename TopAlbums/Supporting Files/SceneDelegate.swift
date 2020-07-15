//
//  SceneDelegate.swift
//  TopAlbums
//
//  Created by Scott Carter on 7/15/20.
//  Copyright © 2020 Scott Carter. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            let albumsViewModel = AlbumsViewModel()

            let albumsViewController = AlbumsViewController()
            albumsViewController.albumsViewModel = albumsViewModel

            let navigationController = UINavigationController(rootViewController: albumsViewController)

            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

