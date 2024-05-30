//
//  Screen5ViewModel.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 29/05/24.
//

import Foundation

/// Viewmodel.
class Screen5ViewModel: ObservableObject {
    
    /// Published property declarations.
     var message :[Message] = []
    var userName :String = ""
    var favourites: Set<Int> = Set<Int>()
    @Published var dataSource:[user] = []
    
    func getData() async throws -> [user] {
      _ = try await withThrowingTaskGroup(of: fetchResult.self) { group -> user in
            group.addTask {
                print("started fetching username Data")
                guard let URLValue = URL(string: "https://hws.dev/username.json") else {
                    throw URLError(.badURL)
                }
                let (data, _) =  try await URLSession.shared.data(from: URLValue)
                let resultantValue = String(decoding: data, as: UTF8.self)
                // returns the username.
                print("Finished fetching username Data")
                return .userName(resultantValue)
            }
            group.addTask {
                print("started fetching user-messages Data")
                guard let URLValue = URL(string: "https://hws.dev/user-messages.json") else {
                    throw URLError(.badURL)
                }
                let (returnedMessage, _) = try await URLSession.shared.data(from: URLValue)
                let resultantUserMessage = try JSONDecoder().decode([Message].self, from: returnedMessage)
                // returns the message.
                print("Finished fetching user-messages Data")
                return .message(resultantUserMessage)
            }
            group.addTask {
                print("started fetching user-favorites.Data")
                guard let URLString = URL(string: "https://hws.dev/user-favorites.json") else {
                    throw URLError(.badURL)
                }
                let (returnedFavouriteList,_) =  try await URLSession.shared.data(from: URLString)
                let  resultantList =  try JSONDecoder().decode(Set <Int>.self, from: returnedFavouriteList)
                // returns the favourite list.
                print("Finished fetching user-favorites Data")
                return .favourite(resultantList)
            }
            do {
                for try await details in  group {
                        switch details {
                        case .favourite(let favouriteList):
                            favourites = favouriteList
                        case .userName(let returnedUserName):
                            userName.append(returnedUserName)
                        case .message(let returnedMessage):
                            message = returnedMessage
                    }
                }
            } catch  {
                print("error--->\(String(describing: error.localizedDescription))")
                throw URLError(.badServerResponse)
            }
            return user(userName:userName, favourite: favourites, message: message)
        }
        let  endResult:[user] = [user(userName:userName, favourite: favourites, message: message)]
        await MainActor.run {
            print("dataSource updated with above value")
            dataSource.append(contentsOf: endResult)
        }
        return dataSource
    }
}


