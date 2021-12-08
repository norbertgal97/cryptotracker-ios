//
//  ProfileViewModel.swift
//  CryptoTracker
//
//  Created by Norbert Gál on 2021. 12. 07..
//

import UIKit

class ProfileViewModel: ObservableObject {
    @Published var showingImagePicker = false
    @Published var pickedImage: UIImage?
    @Published var storedImage: UIImage?
    
    public func getStoredImage(with name: String) {
        if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(name) {
            do {
                let imageData = try Data(contentsOf: fileURL)
                
                storedImage = UIImage(data: imageData)
            } catch {
                print("Error loading image : \(error)")
            }
        }
    }
    
    public func deleteStoredImage(with name: String){
        if let path = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first?.appendingPathComponent(name) {
            //hogy lássuk, mit törölünk ki (szimulátorhoz)
            print("deleting:\(path)")
            try? FileManager.default.removeItem(at: path)
            storedImage = nil
        }
    }
    
    public func setStoredImage(with name: String) {
        if let image = pickedImage {
            if let pngData = image.pngData(), let path = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first?.appendingPathComponent(name) {
                try? pngData.write(to: path)
                storedImage = image
            }
        }
    }
    
}
