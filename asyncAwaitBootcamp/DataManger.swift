//
//  DataManger.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 02/05/24.
//

import Foundation
import UIKit
import SwiftUI
import Combine

/// Class that responsible for API call.
class  DataManger {
    
    /// Singleton architecture implementation.
    static let shared = DataManger()
    private init() {}
    
    /// URL Value.
    let urlValue =  URL(string: "https://picsum.photos/200")!
    
    
    /// Function to extract data as an image if present else returns  a nil value.
    /// - Parameters:
    ///   - returnedData: Is representing the fetched data from API.
    ///   - returnedResponse:Is responsible of holding the returned response from the URL.
    /// - Returns: Returns an optional image.
    func handleResponse(returnedData: Data?, returnedResponse: URLResponse?) -> UIImage? {
        guard let data = returnedData ,
              let convertedData = UIImage(data: data),
              let response = returnedResponse as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode <= 300 else {
            print("error")
            return nil
        }
        return convertedData
    }
    
    /// Function to download image from API.
    /// - Parameter completionHandler: Is an @escaping closure that returns either an image or a error.
    func downloadData(completionHandler:@escaping( _ imageValue: UIImage?,_ error: Error?)->()) {
        URLSession.shared.dataTask(with: urlValue) {[weak self] data, response, error in
            let imageValue = self?.handleResponse(returnedData: data, returnedResponse: response)
            completionHandler(imageValue,error)
        }
        .resume()
    }
    
    /// Function to perform a API call using Combine
    /// - Returns: A AnyPublisher of typw Uimage and error.
    func downloadDataUsingCombine()-> AnyPublisher<UIImage?, Error>
    {
        URLSession.shared.dataTaskPublisher(for: urlValue)
            .map(handleResponse)
            .mapError({$0})
            .eraseToAnyPublisher()
    }
    
    func fetchData()  async throws -> UIImage? {
        do {
            let (data,response) = try await URLSession.shared.data(from: urlValue, delegate: nil)
            let image = handleResponse(returnedData: data, returnedResponse: response)
            return image
        }
        catch {
           throw error
        }
    }
    
    
    
    
}

