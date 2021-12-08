//
//  CryptoListDTO.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import Foundation

class CryptoListDTO: Decodable {
    var data: [CryptoDataDTO]?
    var status: StatusDTO
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        data = try container.decodeIfPresent([CryptoDataDTO].self, forKey: .data)
        status = try container.decode(StatusDTO.self, forKey: .status)
    }
    
    enum CodingKeys: String, CodingKey {
        case data
        case status
    }
}
