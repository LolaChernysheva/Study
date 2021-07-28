//
//  GroupsListTableViewController.swift
//  Study
//
//  Created by Lola Chernysheva on 20.07.2021.
//

import UIKit

class GroupsListTableViewController: UITableViewController {
	
	var searchGroupController = SearchGroupTableViewController()
	public var groupsList = ["Group1", "Group2", "Group3"]

    override func viewDidLoad() {
        super.viewDidLoad()
		initialize()

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
	
	private func initialize() {
		view.backgroundColor = AppAppearence.backgroundColor
		self.modalPresentationStyle = .fullScreen
		let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(goToSearchGroupVC))
		self.navigationItem.rightBarButtonItem = rightButton
		
	}
	
	@objc private func goToSearchGroupVC() {
		searchGroupController.groupListVC = self
		self.navigationController?.pushViewController(searchGroupController, animated: true)
	}


}
