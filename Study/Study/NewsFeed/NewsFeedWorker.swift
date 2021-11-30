//
//  NewsFeedWorker.swift
//  Study
//
//  Created by Лолита Чернышева on 15.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsFeedService {

    var authService: AuthService
    var networking: Networking
    var fetcher: NetworkDataFetcher
    
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    
    init() {
        self.authService = SceneDelegate.shared().authService!
        self.networking = NetworkService(authService: authService)
        self.fetcher = NetworkDataFetcher.init(networking: networking)
    }
    
    func getUser(completion: @escaping (UserResponse?) -> Void) {
        fetcher.getUser { (userResponse) in
            completion(userResponse)
        }
    }
    
    func getFeed(completion: @escaping ([Int], FeedResponse) -> Void) {
        fetcher.getFeed { [ weak self ] (feed) in
            self?.feedResponse = feed
            guard let feedResponse = self?.feedResponse else { return }
            completion(self!.revealedPostIds, feedResponse)
        }
    }
    
    func revealedPostIds(forPostId postId: Int, completion: @escaping ([Int], FeedResponse) -> Void) {
        revealedPostIds.append(postId)
        guard let feedResponse = self.feedResponse else { return }
        completion(revealedPostIds, feedResponse)
    }
}
