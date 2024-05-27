//
//  File.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 24/05/24.
//

import Foundation
import SwiftUI

/// Viewmodel for Screen3.
class Screen3ViewModel: ObservableObject {
    
    /// Published property declarations.
    @Published var image: UIImage?  = nil
    @Published var image2: UIImage?  = nil
    
    /// Function to fetch image from the URL .
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        do {
            guard let url = URL(string: "https://picsum.photos/200" ) else {return}
            let (data, _ ) =  try await URLSession.shared.data(from: url)
            let newValue = UIImage(data: data)
            await MainActor.run {
                self.image = newValue
            }
        }
        catch {
            print("error---->\(error.localizedDescription)")
        }
    }
    
    /// Function to fetch image from the URL.
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200" ) else {return}
            let (data, _ ) =  try await URLSession.shared.data(from: url)
            let newValue = UIImage(data: data)
            await MainActor.run {
                self.image2 = newValue
            }
        }
        catch {
            print("error---->\(error.localizedDescription)")
        }
    }
}
