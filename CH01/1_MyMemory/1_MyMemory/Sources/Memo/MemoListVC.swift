//
//  MemoListVC.swift
//  1_MyMemory
//
//  Created by 권오준 on 2022/08/07.
//

import UIKit

class MemoListVC: UITableViewController {

    // MARK: - Property
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Func

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int
    {
        return self.appDelegate.memoList.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
    {
        let row = self.appDelegate.memoList[indexPath.row]
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellId) as? MemoCell else {
            return UITableViewCell()
        }
        
        cell.updateCell(row)

        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath)
    {
        let row = self.appDelegate.memoList[indexPath.row]
        guard let vc = self.storyboard?.instantiateViewController(
            withIdentifier: "MemoRead") as? MemoReadVC else {
            return
        }
        
        vc.param = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
