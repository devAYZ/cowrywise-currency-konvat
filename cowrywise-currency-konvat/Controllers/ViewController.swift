//
//  ViewController.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 26/03/2025.
//

import UIKit
import SideMenu

class ViewController: UIViewController {
    
    @IBOutlet var exchangeRateButton: UIButton!
    @IBOutlet var sideMenuButtonView: UIImageView!
    @IBOutlet var signUpButton: UIButton!
    
    private var exchangeRateButtonTitle = "Mid-market exchange rate at {t}  "
    public var sideMenu: SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        exchangeRateButton.setTitle(exchangeRateButtonTitle, for: .normal)
        
        setupSideMenu()
        signUpButton.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
    }
    
    func setupSideMenu(rootVC: SideMenuViewController = SideMenuViewController.instantiate()) {
        sideMenu = SideMenuNavigationController(rootViewController: rootVC)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        sideMenuButtonView.addTapGesture(target: self, action: #selector(sideMenuClicked))
    }
    
    @objc func sideMenuClicked() {
        present(sideMenu!, animated: true)
    }
    
    @objc func signUpClicked() {
        showAlert(featureName: "Sign up")
    }
}
