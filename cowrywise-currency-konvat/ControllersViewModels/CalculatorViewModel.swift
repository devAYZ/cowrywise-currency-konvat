//
//  CalculatorViewModel.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 31/03/2025.
//

import Foundation

protocol CalculatorViewModelProtocol {
    func handleLoader(show: Bool)
    func handleError(message: String?)
    func handleSuccess(sysmbols: [String: String]?)
}

class CalculatorViewModel  {
    
    // MARK: Properties
    static let shared = CalculatorViewModel()
    let dataManager = DataManager()
    
    var delegate: CalculatorViewModelProtocol?
    
    func getCurrencyList() {
        self.delegate?.handleLoader(show: true)
        NetworkCallService.shared.makeNetworkCall(with: getCurrencyRequestModel()) { response in
            self.delegate?.handleLoader(show: false)
            switch response.result {
            case .success(let data):
                guard data.success ?? false else {
                    self.delegate?.handleError(message: data.error?.info)
                    return
                }
                self.delegate?.handleSuccess(sysmbols: data.symbols?.symbolsAndValueDictionary)
                self.dataManager.symbolsListData = data.symbols
                RealmManager.shared.saveObject(self.dataManager)
                
            case .failure(let error):
                self.delegate?.handleError(message: error.localizedDescription)
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
}
