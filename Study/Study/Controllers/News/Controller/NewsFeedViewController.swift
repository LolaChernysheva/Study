//
//  NewsFeedViewController.swift
//  Study
//
//  Created by Лолита Чернышева on 07.10.2021.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())

    override func viewDidLoad() {
        super.viewDidLoad()
        fetcher.getFeed { (feedResponse) in
            guard let feedResponse = feedResponse else { return }
            feedResponse.items.map { (feedItem) in
                print(feedItem.date)
            }
        }
    }
}
