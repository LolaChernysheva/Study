//
//  UserResponse.swift
//  Study
//
//  Created by Лолита Чернышева on 25.11.2021.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
