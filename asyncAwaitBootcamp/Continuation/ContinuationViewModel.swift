//
//  ContinuationViewModel.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 31/05/24.
//

import Foundation
import SwiftUI

/// View model.
class ContinuationViewModel: ObservableObject {
    
    /// Published property declarations.
    @Published var imageHolder : UIImage? = nil
    
    /// URL
    let URLString = "https://picsum.photos/200"
    
    /// Fucntion to convert image from the data.
    func getImagesFromAPI() async  {
            let data =  await ContinuationViewModelManager.shared.getImageFromDatabase()
                await MainActor.run {
                    self.imageHolder = data
                }
    }
}

/// Class to initiate a API call.
class ContinuationViewModelManager {
    
    /// Single ton architecture.
    static let shared = ContinuationViewModelManager()
    
    /// Function to fetch data from a specific URL.
    /// - Parameter URLString: API string
    /// - Returns: Data
    func getDataFromAPI(URLString: String) async throws -> Data {
        guard let URLValue = URL(string: URLString) else {throw URLError(.badURL)}
        do {
            let (data,_) =  try await URLSession.shared.data(from: URLValue)
            return data
        }
        catch {
            throw error
        }
    }
    
    /// Function that converts an api that doesn't support an async await  functionality  to one that support it.
    /// - Parameter URLValue: URL for the API call
    /// - Returns: returns  data.
    func getdataFromApi2(from URLValue: URL) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: URLValue) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                }
                else if let error = error {
                    continuation.resume(throwing: error)
                }
                else {
                    continuation.resume(throwing: networkErrors.BadURL)
                }
            }.resume()
        }
    }
    
    func getImageFromDatabase() async -> UIImage? {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                continuation.resume(returning: UIImage(systemName: "heart.fill"))
            }
        }
    }
}

/// Enum for declaring custom errors.
enum networkErrors: Error {
    case DecodingError
    case BadURL
}
