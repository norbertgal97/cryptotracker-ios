//
//  StatusDTO.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import Foundation

class StatusDTO: Decodable {
    var timestamp: String
    var errorCode: Int
    var errorMessage: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        timestamp = try container.decode(String.self, forKey: .timestamp)
        errorCode = try container.decode(Int.self, forKey: .errorCode)
        errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
    }
    
    enum CodingKeys: String, CodingKey {
        case timestamp
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}
