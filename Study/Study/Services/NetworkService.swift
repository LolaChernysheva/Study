//
//  NetworkService.swift
//  Study
//
//  Created by Лолита Чернышева on 07.10.2021.
//

//MARK: - todo
//-убрать опционал в инициализаторе 

import Foundation

protocol Networking {
    //создает url из path и параметров
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService!) {
        self.authService = authService
    }

    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        //возобновление получения данных
        task.resume()
        print(url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            })
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        //протокол
        components.scheme = API.scheme
        //название сайта, с которого мы запрашиваем запрос
        components.host = API.host
        //определяет метод, к которум мы хотим обратиться
        components.path = API.newsFeed
        //параметры
        components.queryItems = params.map{ URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
}
