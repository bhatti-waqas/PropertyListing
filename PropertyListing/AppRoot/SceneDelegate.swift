//
//  SceneDelegate.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/9/21.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    // MARK:- Private Properties
    private var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: winScene)
        let coordinator = AppCoordinator(window: window)
        self.window = window
        self.coordinator = coordinator
        coordinator.start()
    }
}

