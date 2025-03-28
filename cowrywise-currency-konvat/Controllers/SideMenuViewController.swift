//
//  SideMenuViewController.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 27/03/2025.
//

import UIKit

final class SideMenuViewController: UIViewController {
    
    // MARK: Views Outlet
    @IBOutlet var aboutUsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        aboutUsButton.addTarget(self, action: #selector(aboutUsClicked), for: .touchUpInside)
    }
    
    @objc func aboutUsClicked() {
        showAlertComingFeature(featureName: "About Us")
    }

}
