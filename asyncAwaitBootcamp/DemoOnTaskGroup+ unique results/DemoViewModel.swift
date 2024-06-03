//
//  DemoViewModel.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 29/05/24.
//

import Foundation

class DemoViewModel: ObservableObject {
    
    /// <#Description#>
    @Published var dataProvider: [UserModel] = []
    
    var coinDetails :[CoinDetailsModel] = []
    var jobDetails :[Jobs] = []
    
    func fetchDetails()  async throws -> [UserModel] {
        
        _ =  try await withThrowingTaskGroup(of: DataModel.self) { group -> UserModel in
            group.addTask {
                print("Starting coin data fetch")
                guard let URLValue = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
                    throw URLError(.badURL)
                }
                let (data, _) =  try await URLSession.shared.data(from: URLValue)
                let decodedData = try JSONDecoder().decode([CoinDetailsModel].self, from: data)
                print("Coin data fetched and decoded")
                return .coinModel(decodedData)
            }
            group.addTask {
                print("Starting job data fetch")
                guard let URLValue = URL(string: "http://localhost:9001/elixr/jobs") else {
                    throw URLError(.badURL)
                }
                let (data,_) = try await URLSession.shared.data(from: URLValue)
                let decodedData = try JSONDecoder().decode(JobsResponse.self, from: data)
                print("job data fetched and decoded")
                return .jobDetails(decodedData.jobs)
            }
            
            
                for  try await details in group {
                    switch details {
                    case .coinModel(let returnedCoinDetails):
                        coinDetails.append(contentsOf: returnedCoinDetails)
                    case .jobDetails(let returnedJobDetails):
                        jobDetails.append(contentsOf: returnedJobDetails)
                    }
                }
           
            return UserModel(jobInfo: jobDetails, coinInfo: coinDetails)
        }
        let endResult: [UserModel] = [UserModel(jobInfo: jobDetails, coinInfo: coinDetails)]
        await MainActor.run {
            print("dataProvider updated with above value")
            dataProvider.append(contentsOf: endResult)
        }
        print(dataProvider)
        return dataProvider
    }
}

    
