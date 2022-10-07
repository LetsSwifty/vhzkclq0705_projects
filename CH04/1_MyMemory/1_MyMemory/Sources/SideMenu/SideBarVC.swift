//
//  SideBarVC.swift
//  1_MyMemory
//
//  Created by 권오준 on 2022/09/17.
//

import UIKit

import SideMenu

class SideBarVC: UITableViewController {

    // MARK: - Property
    
    let menuData = [
        ("새 글 작성하기", UIImage(named: "icon01.png")),
        ("친구 새 글", UIImage(named: "icon02.png")),
        ("달력으로 보기", UIImage(named: "icon03.png")),
        ("공지사항", UIImage(named: "icon04.png")),
        ("통계", UIImage(named: "icon05.png")),
        ("계정 관리", UIImage(named: "icon06.png")),
    ]
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int
    {
        return self.menuData.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as? MenuCell else {
            return UITableViewCell()
        }

        let menu = menuData[indexPath.row]
        cell.updateCell(menu)
        
        return cell
    }

}
