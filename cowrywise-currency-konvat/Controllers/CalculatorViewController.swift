//
//  CalculatorViewController.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 26/03/2025.
//

import UIKit
import SideMenu

class CalculatorViewController: UIViewController {
    
    // MARK: Views Outlet
    @IBOutlet var exchangeRateButton: UIButton!
    @IBOutlet var sideMenuButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var fromCurrencyView: UIView!
    @IBOutlet var toCurrencyView: UIView!
    @IBOutlet var convertCurrencyButton: UIButton!
    @IBOutlet var getExchangeRateAlertButton: UIButton!
    
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
        sideMenuButton.addTarget(self, action: #selector(sideMenuClicked), for: .touchUpInside)
        fromCurrencyView.addTapGesture(target: self, action:  #selector(fromCurrencyViewClicked))
        toCurrencyView.addTapGesture(target: self, action:  #selector(toCurrencyViewClicked))
        getExchangeRateAlertButton.addTarget(self, action: #selector(getExchangeRateAlertClicked), for: .touchUpInside)
    }
    
    @objc func sideMenuClicked() {
        present(sideMenu!, animated: true)
    }
    
    @objc func signUpClicked() {
        showAlertComingFeature(featureName: "Sign up")
    }
    
    @objc func getExchangeRateAlertClicked() {
        showAlertComingFeature(featureName: "Exchange Rate Alert")
    }
    
    @objc func fromCurrencyViewClicked() {
        let vc = SelectCurrencyViewController.instantiate()
        vc.currencyFlow = .from
        handlePresentSelectCurrency(vc)
    }
    
    @objc func toCurrencyViewClicked() {
        let vc = SelectCurrencyViewController.instantiate()
        vc.currencyFlow = .to
        handlePresentSelectCurrency(vc)
    }
    
    private func handlePresentSelectCurrency(_ vc: SelectCurrencyViewController) {
        present(vc, animated: true)
    }
}
