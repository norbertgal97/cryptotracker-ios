//
//  CryptoDetailsView.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import SwiftUI
import Kingfisher

struct CryptoDetailsView: View {
    let cryptoData: CryptoData
    
    var body: some View {        
        VStack {
            Spacer()
            
            KFImage(URL(string: cryptoData.imageUrl))
                .placeholder{
                    Color.gray
                }
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text(cryptoData.name)
                .fontWeight(.bold)
                .padding(.bottom, 25)
            
            VStack(alignment: .leading, spacing: 10) {
                
                
                HStack(spacing: 5) {
                    Text("Symbol: ")
                        .fontWeight(.bold)
                    
                    Text(cryptoData.symbol)
                }
            
                HStack(spacing: 5) {
                    Text("Circulating supply: ")
                        .fontWeight(.bold)
                    
                    if let circulatingSupply = cryptoData.circulatingSupply, circulatingSupply != -1 {
                        Text(String(circulatingSupply))
                    } else {
                        Text("-")
                    }
                }
                
                HStack(spacing: 5) {
                    Text("Total supply: ")
                        .fontWeight(.bold)
                    
                    if let totalSupply = cryptoData.totalSupply, totalSupply != -1 {
                        Text(String(totalSupply))
                    } else {
                        Text("-")
                    }
                }
                
                HStack(spacing: 5) {
                    Text("Max supply: ")
                        .fontWeight(.bold)
                    
                    if let maxSupply = cryptoData.maxSupply, maxSupply != -1 {
                        Text(String(maxSupply))
                    } else {
                        Text("-")
                    }
                }
                
                HStack(spacing: 5) {
                    Text("Price: ")
                        .fontWeight(.bold)
                    
                    if let price = cryptoData.price, price != -1 {
                        Text("$\(price, specifier: "%.2f")")
                    } else {
                        Text("-")
                    }
                }
                
                HStack(spacing: 5) {
                    Text("Market cap: ")
                        .fontWeight(.bold)
                    
                    if let marketCap = cryptoData.marketCap, marketCap != -1 {
                        Text("$\(marketCap, specifier: "%.2f")")
                    } else {
                        Text("-")
                    }
                }
                
            }
            
            Spacer()
        }
        .navigationBarTitle("Details", displayMode: .inline)
        
    }
}

struct CryptoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoDetailsView(cryptoData: CryptoData(id: 1,
                                                 name: "Bitcoin",
                                                 symbol: "BTC",
                                                 circulatingSupply: 18894425,
                                                 totalSupply: 18894425,
                                                 maxSupply: 21000000,
                                                 price: 50593,
                                                 marketCap: 955936827038,
                                                 imageUrl: NetworkConfig.IMAGE_ENDPOINT_ADDRESS + "1.png"))
    }
}
