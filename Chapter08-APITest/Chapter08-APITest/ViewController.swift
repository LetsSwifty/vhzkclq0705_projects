//
//  ViewController.swift
//  Chapter08-APITest
//
//  Created by 권오준 on 2022/10/11.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI
    
    // GET API 호출 관련
    @IBOutlet weak var currentTime: UILabel!
    
    // POST API 호출 관련
    @IBOutlet weak var userid: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var responseView: UITextView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Func
    
    func updateUIWithURLSession(_ request: URLRequest) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // 5-1. 서버가 응답이 없거나 통신이 실패했을 때
            if let e = error {
                NSLog("An error has occurred: \(e.localizedDescription)")
                return
            }
            // 5-2. 응답 처리 로직
            // ① 메인 스레드에서 비동기로 처리되도록 한다.
            DispatchQueue.main.async {
                do {
                    let object = try JSONSerialization.jsonObject(
                        with: data!,
                        options: []) as? NSDictionary
                    guard let jsonObject = object else { return }
                    
                    // ② JSON 결과값을 추출한다.
                    let result = jsonObject["result"] as? String
                    let timestamp = jsonObject["timestamp"] as? String
                    let userId = jsonObject["userId"] as? String
                    let name = jsonObject["name"] as? String
                    
                    print("Response Data = \(String(data: data!, encoding: .utf8)!)")
                    // ③ 결과가 성공일 때에만 텍스트 뷰에 출력한다.
                    if result == "SUCCESS" {
                        self.responseView.text =
                        """
                        아이디: \(userId!)\n
                        이름: \(name!)\n
                        응답결과: \(result!)\n
                        응답시간: \(timestamp!)\n
                        요청방식: x-www-form-urlencoded
                        """
                    }
                } catch let e as NSError {
                    print("An error has occurred while parsing JSONObject: \(e.localizedDescription)")
                }
            }
        }
        // 6. POST 전송
        task.resume()
    }
    
    func updateUIWithAlamofire() {
        
    }
    
    // MARK: - Action
    
    @IBAction func callCurrentTime(_ sender: Any) {
        do {
            // 1. URL 설정 및 GET 방식으로 API 호출
            let url = URL(string: Address.getTime.url)
            let response = try String(contentsOf: url!)
            
            // 2. 읽어온 값을 레이블에 표시
            self.currentTime.text = response
            self.currentTime.sizeToFit()
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }
    
    @IBAction func post(_ sender: Any) {
        // 1. 전송할 값 준비
        let userId = (self.userid.text)!
        let name = (self.name.text)!
        let param = "userId=\(userId)&name=\(name)"
        let paramData = param.data(using: .utf8)
        
        // 2. URL 객체 정의
        let url = URL(string: Address.post1.url)
        
        // 3. URLRequest 객체를 정의하고, 요청 내용을 담는다.
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        // 4. HTTP 메시지 헤더 설정
        request.addValue(
            "application/x-www-form-urlencoded",
            forHTTPHeaderField: "Content-Type")
        request.setValue(
            String(paramData!.count),
            forHTTPHeaderField: "Content-Length")
        
        // 5. URLSession 객체를 통해 전송 및 응답값 처리 로직 작성
        self.updateUIWithURLSession(request)
    }
    
    @IBAction func json(_ sender: Any) {
        // 1. 전송할 값 준비
        let userId = (self.userid.text)!
        let name = (self.name.text)!
        let param = ["userId": userId, "name": name] // JSON 객체로 변환할 딕셔너리 준비
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        
        // 2. URL 객체 정의
        let url = URL(string: Address.post2.url)
        
        // 3. URLRequest 객체 정의 및 요청 내용 담기
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        // 4. HTTP 메시지에 포함될 헤더 설정
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(param.count), forHTTPHeaderField: "Content-Length")
        
        // 5. URLSession 객체를 통해 전송 및 응답값 처리 로직 작성
        self.updateUIWithURLSession(request)
    }
    
    
}

