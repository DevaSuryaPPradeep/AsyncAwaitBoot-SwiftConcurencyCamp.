//
//  TaskViewModel.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 27/05/24.
//

import Foundation
import SwiftUI

/// ViewModel.
class TaskViewModel: ObservableObject {
    
    /// Published property declarations.
    @Published var dataArray: [UIImage] = []
    
    
    /// Function to update the UI using the value fetched from the fetchImagesWithAsyncLet and asigning it to the published property.
    func getImages() async  {
        if let returnedResult = try? await TaskDataManager.shared.fetchImageWithTaskGroup() {
            await MainActor.run {
                self.dataArray.append(contentsOf: returnedResult)}
            }
        else {
            print(URLError(.badURL))
        }
    }
}
