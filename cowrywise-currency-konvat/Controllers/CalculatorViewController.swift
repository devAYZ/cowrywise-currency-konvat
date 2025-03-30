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
    @IBOutlet var midMarketExRateInfoButton: UIButton!
    @IBOutlet var sideMenuButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var fromCurrencyTextField: UITextField!
    @IBOutlet var toCurrencyTextField: UITextField!
    @IBOutlet var fromCurrencyView: UIView!
    @IBOutlet var toCurrencyView: UIView!
    @IBOutlet var fromCurrencySymbolLabels: [UILabel]!
    @IBOutlet var toCurrencySymbolLabels: [UILabel]!
    @IBOutlet var fromCurrencySymbolImageView: UIImageView!
    @IBOutlet var toCurrencySymbolImageView: UIImageView!
    @IBOutlet var convertCurrencyButton: UIButton!
    @IBOutlet var getEmailAlertForRatesButton: UIButton!
    
    // MARK: Properties
    public var sideMenu: SideMenuNavigationController?
    var currencyFlow: SelectCurrencyFlow?
    private var convertCurrencyFrom: SingleCurrency?
    private var convertCurrencyTo: SingleCurrency?
    private var exchangeRateButtonTitle = "Mid-market exchange rate at {t}  "

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        midMarketExRateInfoButton.setTitle(exchangeRateButtonTitle, for: .normal)
        
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
        midMarketExRateInfoButton.addTarget(self, action: #selector(midMarketExRateInfoButtonClicked), for: .touchUpInside)
        getEmailAlertForRatesButton.addTarget(self, action: #selector(getEmailAlertForRatesClicked), for: .touchUpInside)
        convertCurrencyButton.addTarget(self, action: #selector(handleConvertCurrency), for: .touchUpInside)
    }
    
    @objc func sideMenuClicked() {
        present(sideMenu!, animated: true)
    }
    
    @objc func signUpClicked() {
        showAlertComingFeature(featureName: "Sign up")
    }
    
    @objc func midMarketExRateInfoButtonClicked() {
        showAlertComingFeature(featureName: "Mid Market Info")
    }
    
    @objc func getEmailAlertForRatesClicked() {
        showAlertComingFeature(featureName: "Exchange Rate Email Alert")
    }
    
    @objc func fromCurrencyViewClicked() {
        handlePresentSelectCurrency(.from)
    }
    
    @objc func toCurrencyViewClicked() {
        handlePresentSelectCurrency(.to)
    }
    
    private func handlePresentSelectCurrency(_ currencyFlow: SelectCurrencyFlow) {
        self.currencyFlow = currencyFlow
        let vc = SelectCurrencyViewController.instantiate()
        vc.currencyFlow = currencyFlow
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func handleConvertCurrency() {
        guard convertCurrencyFrom != nil else {
            showAlert(message: "Choose first currency for conversion")
            return
        }
        
        guard convertCurrencyTo != nil else {
            showAlert(message: "Choose second currency for conversion")
            return
        }
        
        
    }
}

extension CalculatorViewController: SelectCurrencyDelegate {
    func didSelectCurrency(_ currency: SingleCurrency) {
        switch currencyFlow {
        case .from:
            convertCurrencyFrom = currency
            fromCurrencySymbolLabels.forEach { $0.text = currency.code }
        case .to:
            convertCurrencyTo = currency
            toCurrencySymbolLabels.forEach { $0.text = currency.code }
        default:
            break
        }
    }
}
