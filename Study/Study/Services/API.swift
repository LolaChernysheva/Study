//
//  API.swift
//  Study
//
//  Created by Лолита Чернышева on 07.10.2021.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.131"
    
    static let newsFeed = "/method/newsfeed.get"
    static let user = "/method/users.get"
    static let getFriends = "/method/friends.get"
    static let getGroups = "/method/groups.get"
    static let getPhotos = "/method/photos.get"
    static let getGroupsBySearch = "/method/groups.search"
}

