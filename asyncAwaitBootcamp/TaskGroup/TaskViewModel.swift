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
    
    @Published var dataArray: [UIImage] = []
    
    func getImages() async throws {
        if let returnedResult = try? await TaskDataManager.shared.fetchImageWithTaskGroup() {
            self.dataArray.append(contentsOf: returnedResult)
        }
    }
}
