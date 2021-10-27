//
//  TabbarController.swift
//  Study
//
//  Created by Lola Chernysheva on 20.07.2021.
//

import UIKit

class TabbarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.modalPresentationStyle = .fullScreen
		delegate = self
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let friendsTableViewController = FriendsListTableViewController()
		let friendsIcon = UITabBarItem(title: "Друзья",
									   image: UIImage(named: "friends.png"),
									   selectedImage: UIImage(named: "friends.png"))
		let groupsTableViewController = GroupsListTableViewController()
		let groupsIcon = UITabBarItem(title: "Сообщества",
									  image: UIImage(named: "groups.png"),
									  selectedImage: UIImage(named: "groups.png"))
        //let newsFeedViewController = FeedViewController()
        let newsFeedViewController = NewsFeedViewController()
        
        let newsIcon = UITabBarItem(title: "Новости",
                                    image: UIImage(named: "homePage"),
                                    selectedImage: UIImage(named: "homePage"))
		//let controllers = [friendsTableViewController, groupsTableViewController]
		let controllers = [UINavigationController(rootViewController: friendsTableViewController), UINavigationController(rootViewController: groupsTableViewController), UINavigationController(rootViewController: newsFeedViewController)]
		
		friendsTableViewController.tabBarItem = friendsIcon
		groupsTableViewController.tabBarItem = groupsIcon
        newsFeedViewController.tabBarItem = newsIcon
		self.viewControllers = controllers
		
	}
    
	//MARC: Delegate method
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		return true
	}

}
