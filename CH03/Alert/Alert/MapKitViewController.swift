//
//  MapKitViewController.swift
//  Alert
//
//  Created by 권오준 on 2022/08/20.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewController()
    }
    
    func configureViewController() {
        // 위치 정보(위/경도) 설정
        let pos = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623)
        
        // 지도에서 보여줄 넓이, 축적 설정 (숫자가 적을수록 좁은 범위 확대)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.005)
        
        // 지도 영역 정의
        let region = MKCoordinateRegion(center: pos, span: span)
        
        // 위치를 핀으로 표시
        let point = MKPointAnnotation()
        
        point.coordinate = pos
        
        // 맵킷 뷰를 생성하고 지도를 뷰에 표시
        lazy var mapkitview: MKMapView = {
            let view = MKMapView()
            view.region = region
            view.regionThatFits(region)
            view.addAnnotation(point)
            
            return view
        }()
        
        self.view = mapkitview
    }
    
}
