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
    
     var friends = [FriendModel(name: "Pavel", isOnline: true),
                    FriendModel(name: "Lolita", isOnline: false),
                    FriendModel(name: "Ivan", isOnline: true),
                    FriendModel(name: "Maria", isOnline: true),
                    FriendModel(name: "Olga", isOnline: false),
                    FriendModel(name: "Svetlana", isOnline: true),
                    FriendModel(name: "Mikhail", isOnline: false),
                    FriendModel(name: "Kristina", isOnline: true),
                    FriendModel(name: "Zinaida", isOnline: false),
                    FriendModel(name: "Oksana", isOnline: false),
                    FriendModel(name: "Sergey", isOnline: true),
                    FriendModel(name: "Alexandr", isOnline: true),
                    FriendModel(name: "Alexandra", isOnline: true),
                    FriendModel(name: "Vadim", isOnline: false),
                    FriendModel(name: "Nastya", isOnline: true),
                    FriendModel(name: "Vera", isOnline: true),
                    FriendModel(name: "Denis", isOnline: true),
                    FriendModel(name: "Ilya", isOnline: true),
                    FriendModel(name: "Alena", isOnline: true),
                    FriendModel(name: "Ira", isOnline: true),
                    FriendModel(name: "Maxim", isOnline: true),
                    FriendModel(name: "Liza", isOnline: true)]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.friendsCellIdentifier)
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.friendsCellIdentifier, for: indexPath) as? FriendsTableViewCell else { return UITableViewCell() }
        cell.friendName.text = friends[indexPath.row].name
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
