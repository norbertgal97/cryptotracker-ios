//
//  ProfileView.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import SwiftUI

struct ProfileView: View {
    @StateObject var profileVM = ProfileViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            if profileVM.storedImage != nil {
                Image(uiImage: profileVM.storedImage!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100, alignment: .center)
                
                Button(action: {
                    profileVM.deleteStoredImage(with: "image.png")
                } ) {
                    Text("Delete the image")
                }
            } else {
                Image(systemName: "camera.metering.unknown")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100, alignment: .center)
                
                Button(action: {
                    profileVM.showingImagePicker = true
                } ) {
                    Text("Pick an image")
                }
            }
            
            Spacer()
            
            VStack {
                Text("Norbert Gál")
                Text("App version: 1.0.0")
            }
            .padding()
            
        }
        .onAppear {
            profileVM.getStoredImage(with: "image.png")
        }
        .sheet(isPresented: $profileVM.showingImagePicker, onDismiss: { profileVM.setStoredImage(with: "image.png") }) {
            ImagePicker(image: self.$profileVM.pickedImage)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
