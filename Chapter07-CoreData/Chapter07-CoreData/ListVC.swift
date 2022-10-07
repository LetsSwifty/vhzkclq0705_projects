//
//  ListVC.swift
//  Chapter07-CoreData
//
//  Created by 권오준 on 2022/10/08.
//

import UIKit
import CoreData

class ListVC: UITableViewController {

    // MARK: - Property
    
    /// 데이터 소스 역할을 할 배열 변수
    lazy var list: [NSManagedObject] = {
        return self.fetch()
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewController()
    }
    
    // MARK: - Setup
    
    func configureViewController() {
        let addBtn = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(add(_:)))
        
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    // MARK: - Function
    
    /// 데이터를 읽어올 메소드
    func fetch() -> [NSManagedObject] {
        // 1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 3. 요청 객체 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Board")
        
        // 3-1. 정렬 속성 설정(내림차순)
        let sort = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        // 4. 데이터 가져오기
        let result = try! context.fetch(fetchRequest)
        
        return result
    }
    
    /// 데이터를 저장하는 메소드
    func save(title: String, contents: String) -> Bool {
        // 1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 3. 관리 객체 생성 & 값 지정
        let object = NSEntityDescription.insertNewObject(
            forEntityName: "Board",
            into: context)
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        // 4. 영구 저장소에 커밋되고 나면 list 프로퍼티에 추가
        do {
            try context.save()
            // self.list.append(object)
            self.list.insert(object, at: 0)
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    /// 데이터를 삭제하는 메소드
    func delete(object: NSManagedObject) -> Bool {
        // 1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 3. 컨텍스트로부터 해당 객체 삭제
        context.delete(object)
        
        // 4. 영구 저장소에 커밋
        do {
            try context.save()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    /// 데이터를 수정하는 메소드
    func edit(object: NSManagedObject, title: String, contents: String) -> Bool {
        // 1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 3. 관리 객체의 값 수정
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        // 영구 저장소에 반영
        do {
            try context.save()
            self.list = self.fetch()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    // MARK: - Action
    
    @objc func add(_ sender: Any) {
        let alert = UIAlertController(title: "게시글 등록", message: nil, preferredStyle: .alert)
        
        // 입력 필드 추가(이름 & 전화번호)
        alert.addTextField() { $0.placeholder = "제목" }
        alert.addTextField() { $0.placeholder = "내용" }
        
        // 버튼 추가(Cancel & Save)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            guard let title = alert.textFields?.first?.text,
                  let contents = alert.textFields?.last?.text else {
                return
            }
            
            // 값을 저장하고 성공이면 TableView reload
            if self.save(title: title, contents: contents) {
                self.tableView.reloadData()
            }
        })
        
        self.present(alert, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int
    {
        return self.list.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
    {
        // 해당하는 데이터 가져오기
        let record = self.list[indexPath.row]
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        
        // 셀을 생성하고, 값 대입
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = contents

        return cell
    }
    
    // TableView 편집 모드의 기본 타입은 .delete이기 때문에 생략해도 되지만,
    // 예기치 않게 스펙이 변경될 경우를 대비하여 명시적으로 지정
    override func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath)
    -> UITableViewCell.EditingStyle
    {
        return .delete
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath)
    {
        let object = self.list[indexPath.row]
        
        if self.delete(object: object) {
            // 코어 데이터에서 삭제되고 나면 배열 목록과 테이블 뷰의 행도 삭제한다.
            self.list.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath)
    {
        // 1. 선택된 행에 해당하는 데이터 가져오기
        let object = self.list[indexPath.row]
        let title = object.value(forKey: "title") as? String
        let contents = object.value(forKey: "contents") as? String
        
        let alert = UIAlertController(title: "게시글 수정", message: nil, preferredStyle: .alert)
        
        // 2. 입력 필드 추가(기존 값 입력)
        alert.addTextField() { $0.text = title }
        alert.addTextField() { $0.text = contents }
        
        // 3. 버튼 추가(Cancel & Save)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            guard let title = alert.textFields?.first?.text,
                  let contents = alert.textFields?.last?.text else {
                return
            }
            
            // 4. 값을 수정하는 메소드를 호출하고 그 결과가 성공이면 TableView 리로드
            if self.edit(object: object, title: title, contents: contents) {
                // self.tableView.reloadData()
                
                // 추가 코드 1) 셀의 내용을 직접 수정
                let cell = self.tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = title
                cell?.detailTextLabel?.text = contents
                
                // 추가 코드 2) 수정된 셀을 첫 번째 행으로 이동시킨다.
                let firstIndexPath = IndexPath(item: 0, section: 0)
                self.tableView.moveRow(at: indexPath, to: firstIndexPath)
            }
        })
        
        self.present(alert, animated: true)
    }


}
