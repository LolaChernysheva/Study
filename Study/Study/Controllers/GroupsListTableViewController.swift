//
//  GroupsListTableViewController.swift
//  Study
//
//  Created by Lola Chernysheva on 20.07.2021.
//

import UIKit

class GroupsListTableViewController: UITableViewController {
	
	private let groupsList = ["Group1", "Group2", "Group3"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
		return groupsList.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = groupsList[indexPath.row]
		cell.imageView?.image = UIImage(named: "VK")
		return cell
	}


}
