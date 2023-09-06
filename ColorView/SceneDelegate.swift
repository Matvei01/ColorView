//
//  SceneDelegate.swift
//  ColorView
//
//  Created by Matvei Khlestov on 07.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let viewController = UINavigationController(rootViewController: MainViewController())
        
        window.rootViewController = viewController
        self .window = window
        window.makeKeyAndVisible()
    }
}

