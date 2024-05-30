//
//  Screen6Model.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 29/05/24.
//

import Foundation

///Coin model.
//struct CoinDetailsModel: Identifiable, Codable, Hashable {
//    let id,symbol,name: String
//    let image: String
//}
struct CoinDetailsModel: Identifiable, Codable, Hashable  {
    let id, symbol, name: String
}

/// Model for jobResponse.
struct JobsResponse:  Codable, Hashable {
    let jobs: [Jobs]
}

/// Dictionary values against the key jobs.
struct Jobs: Identifiable , Codable, Hashable {
    let id: String
    let title: String
    let department: String
    let postedDate: String
    let deadlineDate: String
    let description: String
    let salary: String
    let status: String
    let responsibilities: String
}

enum DataModel {
    case coinModel([CoinDetailsModel])
    case jobDetails([Jobs])
}

struct UserModel: Hashable {
    let jobInfo: [Jobs]
    let coinInfo: [CoinDetailsModel]
}

