//
//  MainVc.swift
//  Foodie
//
//  Created by surya-zstk231 on 13/09/22.
//

import UIKit
import CoreLocation
import GoogleMaps

class MainVc: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var searchBGView: UIView!
    @IBOutlet var searchTxtFieldView: UIView!
    @IBOutlet var mapView: UIView!
    @IBOutlet var bottomScreenViewBase: UIView!
    @IBOutlet var serachField: UITextField!
    @IBOutlet var singleLocationSearchAreaHeight: NSLayoutConstraint!
    let locationManager = CLLocationManager()
    let bottomVc: BottomVc = {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottomVc") as! BottomVc
        return vc
    }()
    let searchVc: SearchVc = {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchVc") as! SearchVc
        vc.modalPresentationStyle = .fullScreen
        return vc
    }()
    
    let placeSearchVc: SearchListVc = {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchListVc") as! SearchListVc
        vc.modalPresentationStyle = .fullScreen
        return vc
    }()
    
    
    @objc func swipeTriggered(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .down:
            Utility.showBottomVc(duration: 0.25, state: .bottom, frame: CGRect(x: 0, y: self.view.bounds.height - 100, width: self.view.bounds.width, height: self.view.bounds.height - 100), serachBg: self.searchBGView, bottomVc: self.bottomVc)
        case .up:
            Utility.showBottomVc(duration: 0.25, state: .full, frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: self.view.bounds.height - 100), serachBg: self.searchBGView, bottomVc: self.bottomVc)
        default: break
        }
    }
    
    var map: GMSMapView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bottomVc.view.frame = CGRect(x: 0, y: self.view.bounds.height - 100, width: self.view.bounds.width, height: self.view.bounds.height - 100)
        bottomVc.boot(cityName: "Chatrapatti", cordinate: "23456687645")
        searchVc.view.frame = CGRect(x: -20, y: (searchTxtFieldView.frame.height + self.view.safeAreaInsets.top), width: self.mapView.bounds.width, height: self.view.bounds.height + 100)
        placeSearchVc.view.frame = CGRect(x: -20, y: (searchTxtFieldView.frame.height + self.view.safeAreaInsets.top), width: self.mapView.bounds.width, height: self.view.bounds.height + 100)
        self.view.addSubview(bottomVc.view)
        
        
        bottomVc.needToPushSearchScreen = { val in
            self.present(self.searchVc, animated: true)
//            self.present(self.placeSearchVc, animated: true)
            Utility.showBottomVc(duration: 0.25, state: .bottom, frame: CGRect(x: 0, y: self.view.bounds.height - 100, width: self.view.bounds.width, height: self.view.bounds.height - 100), serachBg: self.searchBGView, bottomVc: self.bottomVc)
            self.searchVc.bootVc(destination: self.serachField.text == "" ? self.bottomVc.cityNameLabel.text : self.serachField.text)
//            self.placeSearchVc
        }
        
        let topSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeTriggered(_:)))
        topSwipe.direction = .up
        self.bottomVc.topNotchView.addGestureRecognizer(topSwipe)
        let bottomSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeTriggered(_:)))
        bottomSwipe.direction = .down
        self.bottomVc.topNotchView.addGestureRecognizer(bottomSwipe)
        
        self.searchTxtFieldView.layer.cornerRadius = self.searchTxtFieldView.frame.height / 2
        self.serachField.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        map = GMSMapView.map(withFrame: self.mapView.frame, camera: camera)
        guard let map = map else {return}
        let currentPosition = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        map.animate(toLocation: currentPosition)
        map.isMyLocationEnabled = true
        mapView.addSubview(map)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = map
        
        placeSearchVc.passed = { result in
            PlaceManager.getLocationFromID(result.placeID) { placeResult in
                switch placeResult {
                case .success(let placeValue):
                    let camera = GMSCameraPosition.camera(withLatitude: placeValue.coordinate.latitude, longitude: placeValue.coordinate.longitude, zoom: 6.0)
                    self.map = GMSMapView.map(withFrame: self.mapView.frame, camera: camera)
                    guard let map = self.map else {return}
                    map.isMyLocationEnabled = true
                    self.mapView.addSubview(map)
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: placeValue.coordinate.latitude, longitude: placeValue.coordinate.longitude)
                    marker.title = placeValue.name
                    marker.snippet = placeValue.placeID
                    marker.map = map
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        
        PlaceManager.getCurrentPlace { result in
            switch result {
            case .success(let cordinate):
//                let camera = GMSCameraPosition.camera(withLatitude: cordinate.latitude, longitude: cordinate.longitude, zoom: 6.0)
//                self.map = GMSMapView.map(withFrame: self.mapView.frame, camera: camera)
//                guard let map = self.map else {return}
//                map.isMyLocationEnabled = true
//                self.mapView.addSubview(map)
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: cordinate.latitude, longitude: cordinate.longitude)
                marker.title = "Sydney"
                marker.snippet = "Australia"
                marker.map = map
                let currentPosition = CLLocationCoordinate2D(latitude: cordinate.latitude, longitude: cordinate.longitude)
                map.animate(toLocation: currentPosition)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    @IBAction func directionBtnTapped(_ sender: Any) {
        self.present(self.searchVc, animated: true)
        Utility.showBottomVc(duration: 0.25, state: .bottom, frame: CGRect(x: 0, y: self.view.bounds.height - 100, width: self.view.bounds.width, height: self.view.bounds.height - 100), serachBg: self.searchBGView, bottomVc: self.bottomVc)
        searchVc.bootVc(destination: serachField.text == "" ? bottomVc.cityNameLabel.text : serachField.text)

    }
}


extension MainVc: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.serachField.endEditing(true)
        Utility.showBottomVc(duration: 0.25, state: .bottom, frame: CGRect(x: 0, y: self.view.bounds.height - 100, width: self.view.bounds.width, height: self.view.bounds.height - 100), serachBg: self.searchBGView, bottomVc: self.bottomVc)
        self.bottomVc.boot(cityName: serachField.text == "" ? bottomVc.cityNameLabel.text : serachField.text, cordinate: "y828050857807")
        self.serachField.text = nil
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.present(self.placeSearchVc, animated: true)
        self.placeSearchVc.searchView.searchField?.becomeFirstResponder()
    }
}


class Utility {
    static func showBottomVc(duration: CGFloat, state: bottomVcState, frame: CGRect, serachBg: UIView, bottomVc: BottomVc) {
        UIView.animate(withDuration: duration, delay: 0,options: [.curveEaseInOut]) {
            bottomVc.view.frame = frame
            switch state{
            case .bottom:
                serachBg.backgroundColor = .clear//UIColor(named: "AppPrimaryBG")
                bottomVc.topNotchView.layer.cornerRadius = 20
                bottomVc.topNotchView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            case .full:
                serachBg.backgroundColor = UIColor(named: "AppSecondaryBG")
                bottomVc.view.frame = frame
                bottomVc.topNotchView.layer.cornerRadius = 0
            case .keyboardShown:
                serachBg.backgroundColor = UIColor(named: "AppSecondaryBG")
            }
        }
    }
}

enum bottomVcState {
    case bottom, full, keyboardShown
}
