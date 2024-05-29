//
//  Model.swift
//  asyncAwaitBootcamp
//
//  Created by Devasurya on 29/05/24.
//

import Foundation

struct Screen4Model: Identifiable,Codable,Hashable {
    let id: Int
    let title: String
    let strap: String
    let url: URL
}
