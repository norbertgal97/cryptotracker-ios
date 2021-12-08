//
//  CryptoListView.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import SwiftUI

struct CryptoListView: View {
    @StateObject var cryptoListVM = CryptoListViewModel()
    
    var body: some View {
        NavigationView {
            
            List(cryptoListVM.cryptos) { crypto in
                
                
                NavigationLink(destination: CryptoDetailsView(cryptoData: crypto)) {
                    HStack {
                        AsyncImage(url: URL(string: crypto.image)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 30, height: 30, alignment: .center)
                        
                        Text(crypto.name)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text("$ \(crypto.price ?? 0.00, specifier: "%.2f")")
                    }
                }
            }
            .refreshable {
                cryptoListVM.getCryptoPreviews()
            }
            .navigationBarTitle("Cryptos")
            .onAppear {
                cryptoListVM.getCryptoPreviews()
            }
        }
        .alert(isPresented: $cryptoListVM.showingAlert, content: {
            Alert(title: Text("Error"), message: Text(cryptoListVM.alertDescription), dismissButton: .default(Text("OK")) {
                print("Dismiss button pressed")
            })
        })
    }
}

struct CryptoListView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoListView()
    }
}
