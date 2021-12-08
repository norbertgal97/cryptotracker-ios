//
//  CryptoListView.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import SwiftUI
import Kingfisher

struct CryptoListView: View {
    @StateObject var cryptoListVM = CryptoListViewModel()
    
    var body: some View {
        NavigationView {
            List(cryptoListVM.cryptos) { crypto in
                NavigationLink(destination: CryptoDetailsView(cryptoData: crypto)) {
                    HStack {
                        KFImage(URL(string: crypto.imageUrl))
                            .placeholder{
                                Color.gray
                            }
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                        
                        Text(crypto.name)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text("$\(crypto.price ?? 0.00, specifier: "%.2f")")
                    }
                }
            }
            .refreshable {
                cryptoListVM.getCryptoPreviews()
            }
            .navigationBarTitle("Cryptos")
            
        }
        .alert(isPresented: $cryptoListVM.showingAlert, content: {
            Alert(title: Text("Error"), message: Text(cryptoListVM.alertDescription), dismissButton: .default(Text("OK")) {
                print("Dismiss button pressed")
            })
        })
        .onAppear {
            cryptoListVM.fetchDataFromDatabase()
        }
    }
}

struct CryptoListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoListView()
    }
}
