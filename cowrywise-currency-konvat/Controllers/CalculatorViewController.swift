//
//  CalculatorViewController.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 26/03/2025.
//

import Foundation
import UIKit
import SideMenu
import Kingfisher

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
    @IBOutlet var loaderView: UIActivityIndicatorView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var chartViewContainer: UIView!
    
    // MARK: Properties
    private var vmCalculatorView = CalculatorViewModel.shared
    
    public var sideMenu: SideMenuNavigationController?
    var currencyFlow: SelectCurrencyFlow?
    private var convertCurrencyFrom: SingleCurrency?
    private var convertCurrencyTo: SingleCurrency?
    private var amountToConvert: String?
    private var exchangeRateButtonTitle = "Mid-market exchange rate at {t} "
    private var rateLabelTitle = "Rate 1 {from} = {r} {to}"
    private var trackLasttConversion: (from: String, to: String, amount: String)?
    
    var filteredSymbols: [String: String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vmCalculatorView.attachView(view: self)
        
        if let cached = RealmManager.shared.retrieveObject(DataManager.self)?.symbolsListData {
            filteredSymbols = cached.symbolsAndValueDictionary
        } else {
            vmCalculatorView.getCurrencyList()
        }
        
        setupSideMenu()
        
        signUpButton.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        
        fromCurrencyView.addTapGesture(target: self, action:  #selector(fromCurrencyViewClicked))
        toCurrencyView.addTapGesture(target: self, action:  #selector(toCurrencyViewClicked))
        getEmailAlertForRatesButton.addTarget(self, action: #selector(getEmailAlertForRatesClicked), for: .touchUpInside)
        convertCurrencyButton.addTarget(self, action: #selector(handleConvertCurrency), for: .touchUpInside)
        fromCurrencyTextField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        fromCurrencyTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        setupMidMarketExRateInfoButton()
        
        setupCurrencyView()
    }
    
    func setupSideMenu(rootVC: SideMenuViewController = SideMenuViewController.instantiate()) {
        sideMenu = SideMenuNavigationController(rootViewController: rootVC)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        sideMenuButton.addTarget(self, action: #selector(sideMenuClicked), for: .touchUpInside)
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
        vc.filteredSymbols = filteredSymbols
        vc.currencyFlow = currencyFlow
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard var text = textField.text else { return }
        let components = text.split(separator: ".")
        
        // Prevent more than one decimal point
        if components.count > 2 {
            text = String(components[0]) + "." + String(components[1])
        }
        
        // Convert to Double and enforce two decimal places only if necessary
        if let number = Double(text) {
            if text.contains(".") {
                let decimalParts = text.split(separator: ".")
                if decimalParts.count == 2, decimalParts[1].count > 2 {
                    text = String(format: "%.2f", number) // Limit to 2 decimal places
                }
            }
        } else {
            text = ""
        }
        
        textField.text = text
        amountToConvert = text
    }
    
    @objc func textFieldEditingDidEnd(_ sender: UITextField) {
        guard let amountToConvert = sender.text, !amountToConvert.isEmpty else {
            return
        }
        self.amountToConvert = amountToConvert
    }
    
    func setupMidMarketExRateInfoButton() {
        midMarketExRateInfoButton.addTarget(self, action: #selector(midMarketExRateInfoButtonClicked), for: .touchUpInside)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        let timeString = dateFormatter.string(from: .now)
        midMarketExRateInfoButton.setTitle(exchangeRateButtonTitle.replacingOccurrences(of: "{t}", with: timeString), for: .normal)
    }
    
    func setupCurrencyView() {
        let chartView = CurrencyChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartViewContainer.addSubview(chartView)
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: chartViewContainer.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: chartViewContainer.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: chartViewContainer.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: chartViewContainer.bottomAnchor)
        ])
    }
    
    @objc func handleConvertCurrency() {
        
        guard let amountToConvert = amountToConvert else {
            showAlert(message: "Enter amount")
            return
        }
        
        guard let currencyFrom = convertCurrencyFrom else {
            showAlert(message: "Choose first currency for conversion")
            return
        }
        
        guard let currencyTo = convertCurrencyTo else {
            showAlert(message: "Choose second currency for conversion")
            return
        }
        
        guard trackLasttConversion?.from != currencyFrom.code ||
                trackLasttConversion?.to != currencyTo.code ||
                trackLasttConversion?.amount != amountToConvert else {
            showAlert(message: "This is same as previous conversion")
            return
        }
        
        trackLasttConversion = (currencyFrom.code, currencyTo.code, amountToConvert)
        vmCalculatorView.convertCurrency(from: currencyFrom.code, to: currencyTo.code, amount: amountToConvert)
    }
}

extension CalculatorViewController: SelectCurrencyDelegate {
    func didSelectCurrency(_ currency: SingleCurrency) {
        let currencyLogo = String(currency.code.prefix(2))
        let checkCurrencyLogo  = URL(string: "https://flagsapi.com/\(currencyLogo)/flat/64.png")
        switch currencyFlow {
        case .from:
            fromCurrencySymbolImageView.kf.setImage(with: checkCurrencyLogo)
            convertCurrencyFrom = currency
            fromCurrencySymbolLabels.forEach { $0.text = currency.code }
        case .to:
            toCurrencySymbolImageView.kf.setImage(with: checkCurrencyLogo)
            convertCurrencyTo = currency
            toCurrencySymbolLabels.forEach { $0.text = currency.code }
        default:
            break
        }
    }
}

extension CalculatorViewController: CalculatorViewDelegate {
    func handleError(message: String?) {
        rateLabel.isHidden = true
        showAlert(message: message)
    }
    
    func handleSuccess(sysmbols: [String : String]?) {
        filteredSymbols = sysmbols
    }
    
    func handleLoader(show: Bool) {
        switch show {
        case true:
            loaderView.startAnimating()
        case false:
            loaderView.stopAnimating()
        }
    }
    
    func handleSuccess(coversion: ConvertAmountResponse) {
        rateLabel.isHidden = false
        rateLabel.text = rateLabelTitle
            .replacingOccurrences(of: "{from}", with: convertCurrencyFrom?.code ?? "")
            .replacingOccurrences(of: "{r}", with: String(format: "%.2f", coversion.info?.rate ?? 0))
            .replacingOccurrences(of: "{to}", with: convertCurrencyTo?.code ?? "")
            .formattedAsCurrency()
        toCurrencyTextField.text = String(format: "%.2f", coversion.result ?? 0).formattedAsCurrency()
    }
}
