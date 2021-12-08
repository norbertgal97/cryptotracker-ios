//
//  CryptoListViewModel.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import SwiftUI

class CryptoListViewModel: ObservableObject {
    
    @Published var cryptos = [CryptoData]()
    @Published var showingAlert = false
    @Published var alertDescription = "Unknown error"
    
    func getCryptoPreviews() {
        let networkManager = NetworkManager<CryptoListDTO>()
        let urlRequest = networkManager.makeRequest(url: URL(string: NetworkConfig.API_ENDPOINT_ADDRESS  + "listings/latest")!, method: .GET)
        
        networkManager.dataTask(with: urlRequest) { networkStatus, data in
            switch networkStatus {
            case .successful:
                if let unwrappedData = data {
                    if let unwrappedList = unwrappedData.data {
                        DispatchQueue.main.async {
                            self.cryptos = self.convertDTOToModel(from: unwrappedList)
                        }
                    }
                    
                    if unwrappedData.status.errorCode != 0 {
                        DispatchQueue.main.async {
                            self.showingAlert = true
                            self.alertDescription = unwrappedData.status.errorMessage ?? "Unknown error"
                        }
                    }
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    self.showingAlert = true
                    self.alertDescription = "Unknown error"
                }
            }
        }
    }
    
    func convertDTOToModel(from dto: [CryptoDataDTO]) -> [CryptoData] {
        let cryptoPreviews = dto.map {
            CryptoData(id: $0.coinMarketCapId,
                       name: $0.name,
                       symbol: $0.symbol,
                       circulatingSupply: $0.circulatingSupply,
                       totalSupply: $0.totalSupply,
                       maxSupply: $0.maxSupply,
                       price: $0.quote["USD"]?.price,
                       marketCap: $0.quote["USD"]?.marketCap,
                       image: NetworkConfig.IMAGE_ENDPOINT_ADDRESS + String($0.coinMarketCapId) + ".png")
        }
        
        return cryptoPreviews
    }
    
}
