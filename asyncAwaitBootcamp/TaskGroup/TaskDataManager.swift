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
            var imageHolder: [UIImage] = []
            let i = 1
            for _ in i...4{
                guard let self = self else{ throw URLError(.badURL)}
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
    
    /// Fucntion to fetch images concurrently using async let.
    /// - Returns: An array of UIimages.
    func fetchImagesWithAsyncLet() async throws ->[UIImage] {
        async let fetchImage1 = downloadImage()
        async let fetchImage2 = downloadImage()
        let (image1,image2) =  await (try fetchImage1,try fetchImage2)
        return [image1,image2]
    }
}


/*
 By using fetchImagesWithAsyncLet method we are performing two asynchronus API fetch request and awaits for the result altogether, while doing so we will be able to fetch the images concurrently using async let and present it altogether at once.
 *///<- fetchImagesWithAsyncLet <Async let method implementation>

/*
 On using fetchImageWithTaskGroup() function we are implementing an asynchrous function using withThrowingTaskGroup() inbuilt funcionality , by which we will be adding each of Asynchronus functionality using a group (group.addTask), through this inbuit functionalit it will collect all the asynchrounus functionality and deploy it altogether concurrently.
 *///<- fetchImageWithTaskGroup <withThrowingTaskGroup() method implementation>
