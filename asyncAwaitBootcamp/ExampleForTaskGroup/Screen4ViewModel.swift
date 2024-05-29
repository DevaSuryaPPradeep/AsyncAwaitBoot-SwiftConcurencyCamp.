//
//  Screen4ViewModel.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 29/05/24.
//

import Foundation

/// Viewmodel
class Screen4ViewModel: ObservableObject {
    
    /// Published property declarations
    @Published var dataArray: [Screen4Model] = [Screen4Model]()
    
    /// Function to initiate multiiple api calls and collecting the result using the withThrowingtaskmodifier and there by creating a task group.
    func getData() async throws {
        do {
            let result =  try await withThrowingTaskGroup(of: [Screen4Model].self, body: { group -> [Screen4Model] in
                for i in 1...5 {
                    group.addTask {
                        guard let URLValue =  URL(string: "https://hws.dev/news-\(i).json") else {throw URLError(.badURL)}
                        let (data, _) = try await URLSession.shared.data(from: URLValue)
                        return try JSONDecoder().decode([Screen4Model].self, from: data)
                    }
                }
                for try await content in group {
                    await MainActor.run {
                        dataArray += content
                    }
                }
                return dataArray
            })
        } catch  {
            throw URLError(.unknown)
        }
    }
}

