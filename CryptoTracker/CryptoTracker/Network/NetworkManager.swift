//
//  NetworkManager.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import Foundation

class NetworkManager<Res: Decodable> {
    
    private let responseHandler: ResponseHandler<Res>
    private let requestHandler: RequestHandler
    
    init(requestHandler: RequestHandler = RequestHandler(), responseHandler: ResponseHandler<Res> = ResponseHandler()) {
        self.responseHandler = responseHandler
        self.requestHandler = requestHandler
    }
    
    func makeRequest(url: URL, method: HTTPMethod) -> URLRequest? {
        requestHandler.makeRequest(url: url, method: method)
    }
    
    private func decodeResponse(from data: Data) throws -> Res {
        try responseHandler.decodeResponse(from: data)
    }
    
    func dataTask(with URLRequest: URLRequest?, completionHandler: @escaping (NetworkStatus, Res?) -> Void) {
        
        guard let unwrappedURLRequest = URLRequest else {
            completionHandler(.failure(statusCode: nil), nil)
            return
        }
        
        URLSession.shared.dataTask(with: unwrappedURLRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(statusCode: nil), nil)
                return
            }
            
            guard error == nil else {
                completionHandler(.failure(statusCode: httpResponse.statusCode), nil)
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(statusCode: httpResponse.statusCode), nil)
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            do {
                let decodedData: Res = try self.decodeResponse(from: data)
                
                completionHandler(.successful, decodedData)
            } catch {
                completionHandler(.failure(statusCode: httpResponse.statusCode), nil)
            }
            
        }.resume()
        
    }
    
}
