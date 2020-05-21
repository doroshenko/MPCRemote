//
//  SceneDelegate.swift
//  MPCRemote
//
//  Created by doroshenko on 28.02.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let playerView = composer.playerView()

        // Use a UIHostingController as window root view controller.
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: playerView)
        self.window = window
        window.makeKeyAndVisible()
    }
}

extension UISceneDelegate {

    var resolver: Resolver { Core.resolver }
    var dispatch: Dispatcher { Core.dispatcher }
    var composer: Composer { Core.composer }
}
