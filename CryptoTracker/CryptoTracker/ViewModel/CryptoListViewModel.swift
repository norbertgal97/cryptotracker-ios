//
//  CryptoListViewModel.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import SwiftUI
import CoreData

class CryptoListViewModel: NSObject, ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    
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
                        
                        self.deleteItems()
                        self.addItems(items: self.convertDTOToModel(from: unwrappedList))
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
    
    func addItems(items: [CryptoData]) {
        let _: [Crypto] = items.map { crypto in
            let cryp = Crypto(context: viewContext)
            cryp.id = Int32(crypto.id)
            cryp.name = crypto.name
            cryp.symbol = crypto.symbol
            cryp.circulatingSupply = crypto.circulatingSupply ?? -1
            cryp.totalSupply = crypto.totalSupply ?? -1
            cryp.maxSupply = crypto.maxSupply ?? -1
            cryp.price = crypto.price ?? -1
            cryp.marketCap = crypto.marketCap ?? -1
            cryp.imageUrl = crypto.imageUrl
            
            return cryp
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func fetchDataFromDatabase() {
        // Create a fetch request for a specific Entity type
        let fetchRequest: NSFetchRequest<Crypto>
        fetchRequest = Crypto.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Crypto.id, ascending: true)]
        
        // Fetch all objects of one Entity type
        do {
            let objects = try viewContext.fetch(fetchRequest)
            
            cryptos = objects.map{CryptoData(id: Int($0.id) ,
                                             name: $0.name ?? "-",
                                             symbol: $0.symbol ?? "-",
                                             circulatingSupply: $0.circulatingSupply,
                                             totalSupply: $0.totalSupply,
                                             maxSupply: $0.maxSupply,
                                             price: $0.price,
                                             marketCap: $0.marketCap,
                                             imageUrl: $0.imageUrl ?? "-")}
            
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func deleteItems() {
        let fetchRequest: NSFetchRequest<Crypto>
        fetchRequest = Crypto.fetchRequest()
        
        do {
            let objects = try viewContext.fetch(fetchRequest)
            objects.forEach(viewContext.delete)
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
                       imageUrl: NetworkConfig.IMAGE_ENDPOINT_ADDRESS + String($0.coinMarketCapId) + ".png")
        }
        
        return cryptoPreviews
    }
    
}
