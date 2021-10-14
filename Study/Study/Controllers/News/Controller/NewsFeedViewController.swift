//
//  NewsFeedViewController.swift
//  Study
//
//  Created by Лолита Чернышева on 07.10.2021.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    private let networkService: Networking = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        let params = ["filters": "post,photo"]
        networkService.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data else { return }
            let response = try? decoder.decode(FeedResponseWrapped.self, from: data)
        }
    }
}
