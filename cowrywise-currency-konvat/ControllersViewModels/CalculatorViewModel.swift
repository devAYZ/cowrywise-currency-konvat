//
//  CalculatorViewModel.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 31/03/2025.
//

import Foundation

protocol CalculatorViewDelegate {
    func handleLoader(show: Bool)
    func handleError(message: String?)
    func handleSuccess(sysmbols: [String: String]?)
    func handleSuccess(coversion: ConvertAmountResponse)
}

class CalculatorViewModel  {
    
    // MARK: Properties
    static let shared = CalculatorViewModel()
    let dataManager = DataManager()
    var view: CalculatorViewDelegate?
    var networkClass: NetworkCallProtocol?
    
    // MARK: Initialiser
    init(networkClass: NetworkCallProtocol = NetworkCallService()) {
        self.networkClass = networkClass
    }
    
    func attachView(view: CalculatorViewDelegate) {
        self.view = view
    }
    
    func getCurrencyList() {
        self.view?.handleLoader(show: true)
        networkClass?.makeNetworkCall(with: getCurrencyRequestModel()) { response in
            self.view?.handleLoader(show: false)
            switch response.result {
            case .success(let data):
                guard data.success ?? false else {
                    self.view?.handleError(message: data.error?.info)
                    return
                }
                self.dataManager.symbolsListData = data.symbols
                RealmManager.shared.saveObject(self.dataManager)
                self.view?.handleSuccess(sysmbols: data.symbols?.symbolsAndValueDictionary)
                
            case .failure(let error):
                self.view?.handleError(message: error.localizedDescription)
            }
        }
    }
    
    private func getCurrencyRequestModel() -> NetworkCallModel<SymbolsListResponse> {
        return NetworkCallModel(
            endpoint: Endpoint.symbolsList.rawValue,
            responseType: SymbolsListResponse.self,
            requestMethod: .get,
            queryParameters: [
                "access_key" : PlistManager[.apiKey]
            ]
        )
    }
    
    func convertCurrency(from: String, to: String, amount: String) {
        self.view?.handleLoader(show: true)
        networkClass?.makeNetworkCall(with:  convertCurrencyRequestModel(from: from, to: to, amount: amount)) { response in
            self.view?.handleLoader(show: false)
            switch response.result {
            case .success(let data):
                guard data.success ?? false else {
                    self.view?.handleError(message: data.error?.info)
                    return
                }
                self.view?.handleSuccess(coversion: data)
                
            case .failure(let error):
                self.view?.handleError(message: error.localizedDescription)
            }
        }
    }
    
    private func convertCurrencyRequestModel(from: String, to: String, amount: String) -> NetworkCallModel<ConvertAmountResponse> {
        return NetworkCallModel(
            endpoint: Endpoint.convert.rawValue,
            responseType: ConvertAmountResponse.self,
            requestMethod: .get,
            queryParameters: [
                "access_key" : PlistManager[.apiKey],
                "from": from, "to": to, "amount": amount
            ]
        )
    }
}
