//
//  ResponseHandler.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import Foundation

class ResponseHandler<Res :Decodable> {

    func decodeResponse(from data: Data) throws -> Res {
        let decodedData = try JSONDecoder().decode(Res.self, from: data)
        
        return decodedData
    }
}
