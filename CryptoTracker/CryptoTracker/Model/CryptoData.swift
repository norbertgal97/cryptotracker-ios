//
//  CryptoPreview.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 08..
//

import Foundation

struct CryptoData: Identifiable {
    let id: Int
    let name: String
    
    let symbol: String
    let circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    
    let price: Double?
    let marketCap: Double?
    
    let imageUrl: String
}
