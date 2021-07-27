//
//  FriendsListTableViewController.swift
//  Study
//
//  Created by Lola Chernysheva on 20.07.2021.
//

import UIKit

/* MARK: TODO
- добавить кастомную ячейку и подключиь ее
*/
class FriendsListTableViewController: UITableViewController {
	var friends = ["User1", "User2", "User3"]

    override func viewDidLoad() {
        super.viewDidLoad()
		
    }

    // MARK: - Table view data source

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = friends[indexPath.row]
		cell.imageView?.image = UIImage(named: "VK")
		return cell
	}
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return friends.count
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		self.navigationController?.pushViewController(FriendPhotoViewController(), animated: true)

	}


}
