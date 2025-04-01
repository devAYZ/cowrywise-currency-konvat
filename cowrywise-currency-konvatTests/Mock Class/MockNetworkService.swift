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
            completion?(mockSuccessFetchSymbolsListResponse())
        case .failFetchSymbolsList:
            completion?(mockFailFetchSymbolsListResponse())
        case .convertAmount:
            break
        default:
            break
        }
    }
    
    // Mock Success Response
    func mockSuccessFetchSymbolsListResponse<T>() -> AFDataResponse<T> {
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
    
    func mockFailFetchSymbolsListResponse<T>() -> AFDataResponse<T> {
        return DataResponse(
            request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 1,
            result: .failure(
                AFError.responseValidationFailed(reason: .customValidationFailed(
                    error: NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Unit Test Error response"])
                ))
            )
        )
    }
}
