//
//  NetworkDataFetcher.swift
//  Study
//
//  Created by Лолита Чернышева on 14.10.2021.
//

import Foundation

//преобразование полученных json данных в нужный формат
protocol DataFetcher {
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
    func getFriend(response: @escaping (FriendsResponse?) -> Void)
    func getGroups(response: @escaping (GroupsResponse?) -> Void)
    func getPhotos(response: @escaping (PhotoResponse?) -> Void)
    func getGroupsBySearch(response: @escaping (GroupsResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {

    let networking: Networking
    let authService: AuthService
    
    init(networking: Networking, authService: AuthService = SceneDelegate.shared().authService!) {
        self.networking = networking
        self.authService = authService
    }
    
    func getGroupsBySearch(response: @escaping (GroupsResponse?) -> Void) {
        guard let authService = SceneDelegate.shared().authService,
              let token = authService.token,
              let userId = authService.userId
        else { return }
        
        let params = ["access_token": token, "q": "Music", "v": API.version]
        networking.request(path: API.getGroupsBySearch, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data\(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: GroupsResponseWrapped.self, from: data)
            response(decoded?.response)
        }
        
    }
    
    func getPhotos(response: @escaping (PhotoResponse?) -> Void) {
        guard let authService = SceneDelegate.shared().authService,
              let token = authService.token,
              let userId = authService.userId
        else { return }
        let params = ["access_token": token, "album_id": "wall", "v": API.version]
        networking.request(path: API.getPhotos, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data\(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: PhotoResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }

    func getGroups(response: @escaping (GroupsResponse?) -> Void) {
        guard let authService = SceneDelegate.shared().authService,
              let token = authService.token,
              let userId = authService.userId
        else { return }
        let params = ["access_token": token, "user_id": userId, "extended": "1", "v": API.version]
        networking.request(path: API.getGroups, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data\(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: GroupsResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    func getFriend(response: @escaping (FriendsResponse?) -> Void) {

        guard let authService = SceneDelegate.shared().authService,
              let token = authService.token,
              let userId = authService.userId
        else { return }
        
        let params: [String : String] =  ["access_token": token, "user_ids": userId, "order": "hints", "fields": "photo_100", "name_case": "nom", "v" : API.version]
        networking.request(path: API.getFriends, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: FriendsResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void) {
        var params = ["filters": "post,photo"]
        params["start_from"] = nextBatchFrom
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService.userId else { return }
        let params = ["user_ids": userId, "fields": "photo_100"]
        networking.request(path: API.user, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }

            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
    
    private func  decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from,
              let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
