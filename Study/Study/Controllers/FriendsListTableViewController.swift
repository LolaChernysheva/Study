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
    
    var friends = [FriendModel(name: "Pavel", isOnline: true, avatarPath: "1"),
                   FriendModel(name: "Lolita", isOnline: false, avatarPath: "2"),
                   FriendModel(name: "Ivan", isOnline: true, avatarPath: "3"),
                    FriendModel(name: "Maria", isOnline: true, avatarPath: "4"),
                    FriendModel(name: "Olga", isOnline: false, avatarPath: "5"),
                    FriendModel(name: "Svetlana", isOnline: true, avatarPath: "6"),
                    FriendModel(name: "Mikhail", isOnline: false, avatarPath: "7"),
                    FriendModel(name: "Kristina", isOnline: true, avatarPath: "1"),
                    FriendModel(name: "Zinaida", isOnline: false, avatarPath: "2"),
                    FriendModel(name: "Oksana", isOnline: false, avatarPath: "3"),
                    FriendModel(name: "Sergey", isOnline: true, avatarPath: "4"),
                    FriendModel(name: "Alexandr", isOnline: true, avatarPath: "5"),
                    FriendModel(name: "Alexandra", isOnline: true, avatarPath: "6"),
                    FriendModel(name: "Vadim", isOnline: false, avatarPath: "7"),
                    FriendModel(name: "Nastya", isOnline: true, avatarPath: "1"),
                    FriendModel(name: "Vera", isOnline: true, avatarPath: "2"),
                    FriendModel(name: "Denis", isOnline: true, avatarPath: "3"),
                    FriendModel(name: "Ilya", isOnline: true, avatarPath: "4"),
                    FriendModel(name: "Alena", isOnline: true, avatarPath: "5"),
                    FriendModel(name: "Ira", isOnline: true, avatarPath: "6"),
                    FriendModel(name: "Maxim", isOnline: true, avatarPath: "7"),
                    FriendModel(name: "Liza", isOnline: true, avatarPath: "1")]

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
