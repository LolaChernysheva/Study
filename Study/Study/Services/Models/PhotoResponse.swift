//
//  PhotoResponse.swift
//  Study
//
//  Created by Лолита Чернышева on 23.08.2022.
//

import Foundation

struct PhotoResponseWrapped: Decodable {
    let response: PhotoResponse
}

struct PhotoResponse: Decodable {
    let count: Int
    let items: [Photo]
}
