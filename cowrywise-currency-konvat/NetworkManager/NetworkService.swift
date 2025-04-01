//
//  NetworkService.swift
//  cowrywise-currency-konvat
//
//  Created by Ayokunle Fatokimi on 28/03/2025.
//

import Foundation
import Alamofire

public typealias QueryParameters = Parameters

public struct NetworkCallModel<A: Decodable> {
    
    public var endpoint: String
    public var responseType: A.Type
    public var requestMethod: HTTPMethod
    public var queryParameters: QueryParameters?
    
    /// Initialisation
    /// - Parameters:
    ///   - endpoint: The endpoint to be call
    ///   - requestMethod: HTTP request method
    ///   - queryParameters: queryParameters
    public init(endpoint: String,  responseType: A.Type, requestMethod: HTTPMethod, queryParameters: QueryParameters? = nil) {
        self.endpoint = endpoint
        self.responseType = responseType
        self.requestMethod = requestMethod
        self.queryParameters = queryParameters
    }
}

protocol NetworkCallProtocol {
    /// - Parameters:
    ///   - requestModel: requestModel
    ///   - completion: completion handler
    func makeNetworkCall<A: Decodable>(with requestModel: NetworkCallModel<A>, completion: ((AFDataResponse<A>) -> ())? )
}

// MARK: AFNetworkClass
final class NetworkCallService: NetworkCallProtocol {
    
    /// Implement network call using Alamofire
    /// - Parameters:
    ///   - requestModel: requestModel
    ///   - completion: completion handler
    // MARK: API call
    func makeNetworkCall<A: Decodable>(with requestModel: NetworkCallModel<A>, completion: ((AFDataResponse<A>) -> ())?
    ) {
        
        let requestMethod = requestModel.requestMethod
        let requestUrl = Endpoint.https.rawValue + PlistManager[.baseUrl] + requestModel.endpoint
        let responseType = requestModel.responseType
        
        let requestHeaders: HTTPHeaders = [
            "x-channel": "iOS",
            "x-lang": "EN"
        ]
        
        print("\n*******STARTS Network call\n")
        
        let request = AF.request(requestUrl, method: requestMethod,
                                 parameters: requestModel.queryParameters,
                                 encoding: URLEncoding.default,
                                 headers: requestHeaders) { urlRequest in
            // urlRequest
        }
        
        request
            .validate()
            .responseDecodable(of: responseType) { response in
                debugPrint(response)
                print("\n******COMPLETES Network call\n")
                completion?(response)
            }
    }
}
