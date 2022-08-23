//
//  FriendsResponse.swift
//  Study
//
//  Created by Лолита Чернышева on 23.08.2022.
//

import Foundation

struct FriendsResponseWrapped: Decodable {
    let response: FriendsResponse
}

struct FriendsResponse: Decodable {
    let count: Int
    let items: [Friend]
}

struct Friend: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
}
