//
//  MenuCell.swift
//  1_MyMemory
//
//  Created by 권오준 on 2022/09/17.
//

import UIKit

class MenuCell: UITableViewCell {

    // MARK: - UI
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Func
    
    func updateCell(_ data: (String, UIImage?)) {
        self.label.text = data.0
        self.img.image = data.1
    }
    
}
