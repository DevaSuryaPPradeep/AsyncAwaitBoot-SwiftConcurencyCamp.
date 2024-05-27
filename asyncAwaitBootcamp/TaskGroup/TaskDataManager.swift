//
//  Datamanager.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 27/05/24.
//

import Foundation
import SwiftUI

/// Class responsible to download data from the API.
class TaskDataManager {
    
    /// Implementation of singleton architecture
    static let shared = TaskDataManager()
    private init(){}
    
    /// URL decalarations.
    let URLString = "https://picsum.photos/200"
    
    /// Funtion to fetch images from the URL.
    /// - Returns: Returns a UIImage.
    private func downloadImage() async  throws -> UIImage {
        guard let URLValue = URL(string: URLString) else {throw URLError(.badURL)}
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
    
    /// Function to group tasks altogether using withThrowingTaskGroup().
    /// - Returns: An array of UIImages
    func fetchImageWithTaskGroup()async throws ->[UIImage] {
        return try await  withThrowingTaskGroup(of: UIImage.self) {[weak self] group in
            guard let self = self else{ throw URLError(.badURL)}
            var imageHolder: [UIImage] = []
            let i = 1
            for _ in i...4{
                group.addTask {
                    try await  self.downloadImage()
                }
            }
            for try await returnedImage in group {
                imageHolder.append(returnedImage)
            }
            return imageHolder
        }
    }
}
