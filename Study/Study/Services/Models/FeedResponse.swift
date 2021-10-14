//
//  FeedResponse.swift
//  Study
//
//  Created by Лолита Чернышева on 14.10.2021.
//

import Foundation

//подписываем структуру под протокол Decodablе для возможности преобразования json в модель данных, которая описывается в структуре

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
}

struct CountableItem: Decodable {
    let count: Int
}