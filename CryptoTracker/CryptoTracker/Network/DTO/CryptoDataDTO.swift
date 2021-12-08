//
//  CryptoPreviewDTO.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import Foundation

class CryptoDataDTO: Decodable {
    var coinMarketCapId: Int
    var name: String
    var symbol: String
    var circulatingSupply: Double?
    var totalSupply: Double?
    var maxSupply: Double?
    var quote: [String : QuoteDTO]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        coinMarketCapId = try container.decode(Int.self, forKey: .coinMarketCapId)
        name = try container.decode(String.self, forKey: .name)
        symbol = try container.decode(String.self, forKey: .symbol)
        circulatingSupply = try container.decodeIfPresent(Double.self, forKey: .circulatingSupply)
        totalSupply = try container.decodeIfPresent(Double.self, forKey: .totalSupply)
        maxSupply = try container.decodeIfPresent(Double.self, forKey: .maxSupply)
        quote = try container.decode([String : QuoteDTO].self, forKey: .quote)
    }
    
    enum CodingKeys: String, CodingKey {
        case coinMarketCapId = "id"
        case name
        case symbol
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case quote
    }
}
