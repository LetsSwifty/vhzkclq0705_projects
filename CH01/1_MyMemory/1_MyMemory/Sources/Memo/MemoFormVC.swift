//
//  MemoFormVC.swift
//  1_MyMemory
//
//  Created by 권오준 on 2022/08/07.
//

import UIKit

class MemoFormVC: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    // MARK: - Property
    
    var subject: String!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    // MARK: - Setup
    
    func configureViewController() {
        self.contents.delegate = self
    }

    
    // MARK: - Action
    
    @IBAction func save(_ sender: Any) {
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(
                title: nil,
                message: "내용을 입력해주세요.",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alert, animated: true)
            return
        }
        
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.memoList.append(data)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: false)
    }
    
}

// MARK: - ImagePickerControllerDelegate

extension MemoFormVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        self.preview.image = info[.editedImage] as? UIImage
        
        picker.dismiss(animated: true)
    }
    
}

// MARK: - TextViewDelegate

extension MemoFormVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = (contents.length > 15) ? 15 : contents.length
        
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        self.title = self.subject
    }
    
}

// MARK: - NavigationControllerDelegate

extension MemoFormVC: UINavigationControllerDelegate {
    
}
