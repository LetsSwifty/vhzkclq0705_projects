//
//  UIViewController++Extensions.swift
//  TabBar
//
//  Created by 권오준 on 2022/08/20.
//

import UIKit

extension UIViewController {
    
    func addTitle(_ text: String) {
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        title.text = text
        title.textColor = .red
        title.textAlignment = .center
        title.font = .boldSystemFont(ofSize: 14)
        
        title.sizeToFit()
        title.center.x = self.view.frame.width / 2
        
        self.view.addSubview(title)
    }
    
}
