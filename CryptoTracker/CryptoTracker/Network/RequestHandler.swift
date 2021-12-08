//
//  RequestHandler.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import Foundation

class RequestHandler {    
    func makeRequest(url: URL, method: HTTPMethod) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(NetworkConfig.API_KEY , forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
