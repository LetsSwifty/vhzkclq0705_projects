//
//  ViewController.swift
//  NavigationBar
//
//  Created by 권오준 on 2022/08/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }

    func configureNavigationBar() {
        createTitleTextField()
        createLeftItem()
        createRightItems()
    }
    
    func createTitleTextField() {
        let tf = UITextField()
        
        tf.frame = CGRect(x: 0, y: 0, width: 300, height: 35)
        tf.backgroundColor = .white
        tf.font = .systemFont(ofSize: 13)
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .URL
        tf.keyboardAppearance = .dark
        tf.layer.borderWidth = 0.3
        tf.layer.borderColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0).cgColor
        
        self.navigationItem.titleView = tf
    }
    
    func createLeftItem() {
        let back = UIImage(named: "arrow-back")
        let leftItem = UIBarButtonItem(
            image: back,
            style: .plain,
            target: self,
            action: nil)
        
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func createRightItems() {
        let rv = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 37))
        let rItem = UIBarButtonItem(customView: rv)
        let cnt = UILabel(frame: CGRect(x: 10, y: 8, width: 20, height: 20))
        
        cnt.font = .boldSystemFont(ofSize: 10)
        cnt.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        cnt.text = "12"
        cnt.textAlignment = .center
        cnt.layer.cornerRadius = 3
        cnt.layer.borderWidth = 2
        cnt.layer.borderColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1).cgColor
        
        let more = UIButton(type: .system)
        
        more.frame = CGRect(x: 50, y: 10, width: 16, height: 16)
        more.setImage(UIImage(named: "more"), for: .normal)
        
        [cnt, more].forEach { rv.addSubview($0) }
        self.navigationItem.rightBarButtonItem = rItem
    }
}

