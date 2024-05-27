//
//  AsynLetViewModel.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 27/05/24.
//

import Foundation
import SwiftUI

class AsynLetViewModel: ObservableObject {
    
    @Published var dataArray: [UIImage] = []
    let URLString = "https://picsum.photos/200"
    
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
