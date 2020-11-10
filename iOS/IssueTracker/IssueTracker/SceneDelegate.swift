//
//  SceneDelegate.swift
//  IssueTracker
//
//  Created by ParkJaeHyun on 2020/10/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions)
    {

        if NetworkService.token != "" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "UITabBarController")
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

}
