//
//  MapAlertViewController.swift
//  Alert
//
//  Created by 권오준 on 2022/08/20.
//

import UIKit
import MapKit

class MapAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()
    }
    
    func createButton() {
        lazy var button: UIButton = {
            let button = UIButton(type: .system)
            button.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
            button.center.x = self.view.frame.width / 2
            button.setTitle("기본 알림창", for: .normal)
            button.addTarget(
                self,
                action: #selector(didTapButton(_:)),
                for: .touchUpInside)
            
            return button
        }()
        
        self.view.addSubview(button)
    }
    
    func mapAlert() {
        let alert = UIAlertController(
            title: nil,
            message: "여기가 맞습니까?",
            preferredStyle: .alert)
        
        let cancleAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        [cancleAction, okAction].forEach { alert.addAction($0) }
        
        let contentVC = MapKitViewController()
        
        alert.setValue(contentVC, forKey: "contentViewController")
        
        self.present(alert, animated: true)
    }
    
    @objc func didTapButton(_ sender: Any) {
        mapAlert()
    }


}
