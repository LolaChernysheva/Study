//
//  WebImageView.swift
//  Study
//
//  Created by Лолита Чернышева on 27.10.2021.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentUrlString: String?
    
    func set(imageURL: String?) {
        
        currentUrlString = imageURL
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
            return }
        //проверяем наличие изображения в кэш
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            //если изображение существует, то подружаем его из кэша
            self.image = UIImage(data: cachedResponse.data)
            //print("from cachе")
            return
        }
        //если изображения в кэш нет, то выполняем загружку из интернета
        //print("from internet")
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    //добавляем изображение в кэш
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        //кэшированный ответ
        let cachedResponse = CachedURLResponse(response: response, data: data)
        //обращаемся к объекту, который хранит кэш и передаем кэшированный ответ
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
        
        if responseURL.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        } 
    }
}

