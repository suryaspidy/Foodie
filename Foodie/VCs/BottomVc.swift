//
//  BottomVc.swift
//  Foodie
//
//  Created by surya-zstk231 on 13/09/22.
//

import UIKit

class BottomVc: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet var topNotchView: UIView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var directionBtn: UIButton!
    @IBOutlet var cityCordinateLabel: UILabel!
    
    var needToPushSearchScreen: ((String?)-> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topNotchView.layer.cornerRadius = 20
        self.topNotchView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        directionBtn.layer.cornerRadius = 25
    }
    
    func boot(cityName: String?, cordinate: String?) {
        cityNameLabel.text = cityName
        cityCordinateLabel.text = cordinate
    }
    
    @IBAction func directionBtnTapped(_ sender: Any) {
        needToPushSearchScreen?(cityNameLabel.text)
    }
}
