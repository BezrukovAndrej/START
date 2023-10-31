//
//  SceneDelegate.swift
//  Start Cinema
//
//  Created by Andrey Bezrukov on 23.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        if !UserDefaults.standard.bool(forKey: "hasShownOnboarding") {
            UserDefaults.standard.set(true, forKey: "hasShownOnboarding")
            let onboardingViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            window.rootViewController = onboardingViewController
        } else {
            let tabBarVC = MainTabBarViewController()
            window.rootViewController = tabBarVC
        }
        window.makeKeyAndVisible()
        self.window = window
    }
}
