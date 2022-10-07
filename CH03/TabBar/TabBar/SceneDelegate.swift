//
//  SceneDelegate.swift
//  TabBar
//
//  Created by 권오준 on 2022/08/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }
        
        let tbItemProxy = UITabBarItem.appearance()
        
        tbItemProxy.setTitleTextAttributes([.foregroundColor: UIColor.red], for: .selected)
        tbItemProxy.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .disabled)
        tbItemProxy.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
        
        let tbProxy = UITabBar.appearance()
        
        tbProxy.tintColor = .white
        tbProxy.backgroundImage = UIImage(named: "menubar-bg-mini")
        
        if let tbC = self.window?.rootViewController as? UITabBarController {
            
            
            if let tbItems = tbC.tabBar.items {
                tbItems[0].image = UIImage(named: "calendar")
                tbItems[1].image = UIImage(named: "file-tree")
                tbItems[2].image = UIImage(named: "photo")
                
                tbItems[0].title = "calendar"
                tbItems[1].title = "file"
                tbItems[2].title = "photo"
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

