//
//  MockNetworkService.swift
//  cowrywise-currency-konvatTests
//
//  Created by Ayokunle Fatokimi on 01/04/2025.
//

import Foundation
@testable import cowrywise_currency_konvat
import Alamofire

enum MockNetworkServiceFlow {
    case successFetchSymbolsList
    case failFetchSymbolsList
    case convertAmount
}

struct MockNetworkService: NetworkCallProtocol {
    var shouldReturnSuccess = true
    var mockSymbolsResponse: SymbolsListResponse?
    var mockConversionResponse: ConvertAmountResponse?
    var mockError: Error?
    var apiFlow: MockNetworkServiceFlow?

    func makeNetworkCall<A>(with requestModel: NetworkCallModel<A>, completion: ((AFDataResponse<A>) -> ())?) where A : Decodable {
        
        switch apiFlow {
        case .successFetchSymbolsList:
            completion?(fetchSupportedCurrencyMockSuccesResponse())
        case .failFetchSymbolsList:
            completion?(fetchSupportedCurrencyMockFailResponse())
        case .convertAmount:
            break
        default:
            break
        }
    }
    
    // MARK: Fetch Currenct Symbols MOCK API Response
    func fetchSupportedCurrencyMockSuccesResponse<T>() -> AFDataResponse<T> {
        return DataResponse(
            request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 1,
            result: .success(
                SymbolsListResponse(
                    success: true,
                    error: nil,
                    symbols: SymbolsList(
                        GBP: "British Pound Sterling",
                        CNY: "Chinese Yuan",
                        NGN: "Nigerian Naira",
                        USD: "United States Dollar",
                        EUR: "Euro"
                    )
                ) as! T
            )
        )
    }
    
    func fetchSupportedCurrencyMockFailResponse<T>() -> AFDataResponse<T> {
        return DataResponse(
            request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 1,
            result: .failure(
                AFError.responseValidationFailed(reason: .customValidationFailed(
                    error: NSError(domain: "", code: 400,
                                   userInfo: [NSLocalizedDescriptionKey: "Fetch-curency Unit-test Error-response"])
                ))
            )
        )
    }
    
    // MARK: Convert Currenct MOCK API Response
    func convertCurrencyMockSuccesResponse<T>() -> AFDataResponse<T> {
        return DataResponse(
            request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 1,
            result: .success(
                ConvertAmountResponse(
                    info: Info(timestamp: 1, rate: 1.2),
                    date: "mock-Date",
                    success: true,
                    query: Query(to: "mock-to", amount: 2, from: "mock-from"),
                    historical: "mock-historical",
                    result: 3.3,
                    error: nil
                ) as! T
            )
        )
    }
    
    func convertCurrencyMockFailResponse<T>() -> AFDataResponse<T> {
        return DataResponse(
            request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 1,
            result: .failure(
                AFError.responseValidationFailed(reason: .customValidationFailed(
                    error: NSError(domain: "", code: 400,
                                   userInfo: [NSLocalizedDescriptionKey: "Cnovert-currency Unit-test Error-response"]
                                  )
                ))
            )
        )
    }
}
