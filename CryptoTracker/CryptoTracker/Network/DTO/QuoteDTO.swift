//
//  QuoteDTO.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 08..
//

import Foundation

class QuoteDTO: Decodable {
    var price: Double
    var marketCap: Double
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        price = try container.decode(Double.self, forKey: .price)
        marketCap = try container.decode(Double.self, forKey: .marketCap)
    }
    
    enum CodingKeys: String, CodingKey {
        case price
        case marketCap = "market_cap"
    }
}
