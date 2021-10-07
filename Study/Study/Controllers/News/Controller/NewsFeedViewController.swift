//
//  NewsFeedViewController.swift
//  Study
//
//  Created by Лолита Чернышева on 07.10.2021.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getFeed() 

        // Do any additional setup after loading the view.
    }
}
