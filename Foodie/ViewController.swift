//
//  LaunchScreenVC.swift
//  Foodie
//
//  Created by surya-zstk231 on 22/09/22.
//

import UIKit
import Lottie
class LaunchScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let lottieView = AnimationView(name: "LaunchScreenLottie")
        lottieView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        lottieView.contentMode = .scaleToFill
        lottieView.loopMode = .playOnce
        lottieView.center = self.view.center
        self.view.addSubview(lottieView)
    }
    
}
