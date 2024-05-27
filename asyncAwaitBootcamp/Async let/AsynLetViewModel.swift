//
//  AsynLetViewModel.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 27/05/24.
//

import Foundation
import SwiftUI

/// Viemodel
class AsynLetViewModel: ObservableObject {
    
    /// Published property declarations.
    @Published var dataArray: [UIImage] = []
    
    /// URL decalarations.
    let URLString = "https://picsum.photos/200"
    
    /// Funtion to fetch images from the URL.
    /// - Returns: Returns a UIImage.
    func downloadImage() async  throws -> UIImage {
        guard let URLValue = URL(string: URLString) else {
            throw URLError(.badURL)
        }
        do {
            let (returnedData, _) = try await URLSession.shared.data(from: URLValue)
            if let returnedImage = UIImage(data: returnedData) {return returnedImage}
            else {
                throw URLError(.unknown)
            }
        } catch  {
            throw URLError(.unknown)
        }
    }
    
}
