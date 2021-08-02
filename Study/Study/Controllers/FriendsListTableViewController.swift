//
//  FriendsListTableViewController.swift
//  Study
//
//  Created by Lola Chernysheva on 20.07.2021.
//

/* MARK:- TODO
 обработать переиспользование ячеек
 */

import UIKit


class FriendsListTableViewController: UITableViewController {
    
    var friends = [FriendModel(name: "Pavel", isOnline: true, avatarPath: "VK"),
                   FriendModel(name: "Lolita", isOnline: false, avatarPath: "VK"),
                   FriendModel(name: "Ivan", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Maria", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Olga", isOnline: false, avatarPath: "VK"),
                    FriendModel(name: "Svetlana", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Mikhail", isOnline: false, avatarPath: "VK"),
                    FriendModel(name: "Kristina", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Zinaida", isOnline: false, avatarPath: "VK"),
                    FriendModel(name: "Oksana", isOnline: false, avatarPath: "VK"),
                    FriendModel(name: "Sergey", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Alexandr", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Alexandra", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Vadim", isOnline: false, avatarPath: "VK"),
                    FriendModel(name: "Nastya", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Vera", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Denis", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Ilya", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Alena", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Ira", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Maxim", isOnline: true, avatarPath: "VK"),
                    FriendModel(name: "Liza", isOnline: true, avatarPath: "VK")]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.friendsCellIdentifier)
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.friendsCellIdentifier, for: indexPath) as? FriendsTableViewCell else { return UITableViewCell() }
        cell.friendName.text = friends[indexPath.row].name
        cell.friendAvatar.avatarImageView.image = UIImage(named: friends[indexPath.row].avatarPath)
        return cell
	}
	
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		self.navigationController?.pushViewController(FriendPhotoViewController(), animated: true)
	}
}
