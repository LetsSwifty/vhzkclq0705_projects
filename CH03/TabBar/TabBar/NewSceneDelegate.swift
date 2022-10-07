//
//  NewSceneDelegate.swift
//  TabBar
//
//  Created by 권오준 on 2022/08/20.
//

import UIKit

class NewSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        configureRootViewController()
    }
    
    func configureRootViewController() {
        // 탭 바 컨트롤러 생성 후, 배경색 변경
        let tbC = UITabBarController()
        tbC.view.backgroundColor = .white
        
        // 생성한 탭 바 컨트롤러를 루트 뷰 컨트롤러로 등록
        self.window?.rootViewController = tbC
        self.window?.makeKeyAndVisible()
        
        // 탭 바 아이템에 연결될 뷰 컨트롤러 객체 생성
        let firstVC = ViewController()
        let secondVC = SecondViewController()
        let thirdVC = ThirdViewController()
        
        // 생성된 뷰 컨트롤러 객체를 탭 바 컨트롤러에 등록
        tbC.setViewControllers([firstVC, secondVC, thirdVC], animated: true)
        
        // 개별 탭 바 아이템 속성 설정
        firstVC.tabBarItem = createTabBarItem("Calendar", "calendar")
        secondVC.tabBarItem = createTabBarItem("File", "file-tree")
        thirdVC.tabBarItem = createTabBarItem("Photo", "photo")
        
        // 탭 바 속성 통합 설정
        tbC.tabBar.standardAppearance = initTabBarAppearance()
        tbC.tabBar.scrollEdgeAppearance = tbC.tabBar.standardAppearance
    }
    
    func initTabBarAppearance() -> UITabBarAppearance {
        let tbProxy = UITabBarAppearance()
        
        tbProxy.configureWithOpaqueBackground()
        tbProxy.backgroundImage = UIImage(named: "menubar-bg-mini")
        
        let tbItemProxy = tbProxy.stackedLayoutAppearance
        
        tbItemProxy.normal.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 15)]
        tbItemProxy.selected.iconColor = .white
        tbItemProxy.selected.titleTextAttributes = [.foregroundColor: UIColor.red]
        tbItemProxy.disabled.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        return tbProxy
    }
    
    func createTabBarItem(_ title: String?, _ image: String?) -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: UIImage(named: image ?? ""),
            selectedImage: nil)
    }
    
}
