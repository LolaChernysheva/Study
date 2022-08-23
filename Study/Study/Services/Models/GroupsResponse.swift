//
//  GroupsResponse.swift
//  Study
//
//  Created by Лолита Чернышева on 23.08.2022.
//

import Foundation

struct GroupsResponseWrapped: Decodable {
    let response: GroupsResponse
}

struct GroupsResponse: Decodable {
    let count: Int?
    let items: [Group]
}
