//
//  FriendsListTableViewController.swift
//  Study
//
//  Created by Lola Chernysheva on 20.07.2021.
//

import UIKit


class FriendsListTableViewController: UITableViewController {
    
	static var friends = ["User1", "User2", "User3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.friendsCellIdentifier)
    }


	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.friendsCellIdentifier, for: indexPath)
        return cell
	}
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return FriendsListTableViewController.friends.count
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		self.navigationController?.pushViewController(FriendPhotoViewController(), animated: true)

	}


}
