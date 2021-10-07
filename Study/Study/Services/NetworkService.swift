//
//  NetworkService.swift
//  Study
//
//  Created by Лолита Чернышева on 07.10.2021.
//

//MARK: - todo
//-убрать опционал в инициализаторе 

import Foundation

final class NetworkService {
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService!) {
        self.authService = authService
    }
    
    func getFeed() {
        
        var components = URLComponents()
        //https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.131
        
        guard let token = authService.token else { return }
        let params = ["filters" : "post,photo"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
         
        //протокол
        components.scheme = API.scheme
        //название сайта, с которого мы запрашиваем запрос
        components.host = API.host
        //определяет метод, к которум мы хотим обратиться
        components.path = API.newsFeed
        //параметры
        components.queryItems = allParams.map{ URLQueryItem(name: $0, value: $1)}
        
        guard let url = components.url else { return }
        print(url)
    }
}
