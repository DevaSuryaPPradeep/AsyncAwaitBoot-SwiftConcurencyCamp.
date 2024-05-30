//
//  Screen5Model.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 29/05/24.
//

import Foundation

/// Model for the data related to message.
struct Message: Decodable,Hashable {
    let id: Int
    let from: String
    let message: String
}

/// Model related to user.
struct user :Decodable ,Hashable{
    let userName: String
    let favourite: Set <Int>
    let message: [Message]
}


/// An enum  with asociated values
enum fetchResult {
    case userName(String)
    case favourite(Set<Int>)
    case message([Message])
}
