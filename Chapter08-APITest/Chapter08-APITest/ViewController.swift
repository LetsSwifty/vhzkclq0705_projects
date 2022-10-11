//
//  ViewController.swift
//  Chapter08-APITest
//
//  Created by 권오준 on 2022/10/11.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var currentTime: UILabel!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Func
    
    
    
    // MARK: - Action
    
    @IBAction func callCurrentTime(_ sender: Any) {
        do {
            // 1. URL 설정 및 GET 방식으로 API 호출
            let url = URL(string: Address.getTime.rawValue)
            let response = try String(contentsOf: url!)
            
            // 2. 읽어온 값을 레이블에 표시
            self.currentTime.text = response
            self.currentTime.sizeToFit()
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }

}

