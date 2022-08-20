//
//  ViewController.swift
//  TabBar
//
//  Created by 권오준 on 2022/08/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addTitle("첫번째 탭")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = self.tabBarController?.tabBar
        
        UIView.animate(withDuration: 0.15) {
            tabBar?.alpha = (tabBar?.alpha == 0) ? 1 : 0
        }
    }

}

