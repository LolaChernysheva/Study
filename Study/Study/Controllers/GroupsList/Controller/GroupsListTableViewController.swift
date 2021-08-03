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
        self.navigationItem.title = "Сообщества"
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
	
	//удаление ячейки
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		switch editingStyle {
		case .delete:
			searchGroupController.groupToAdd.append(groupsList[indexPath.row])
			searchGroupController.tableView.reloadData()
			groupsList.remove(at: indexPath.row)
			tableView.reloadData()
			
		default:
			return
		}
	}
	
	private func initialize() {
		view.backgroundColor = AppAppearence.backgroundColor
		self.modalPresentationStyle = .fullScreen
		let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(goToSearchGroupVC))
		self.navigationItem.rightBarButtonItem = rightButton
		
	}
	
	//переход на экран поиска
	@objc private func goToSearchGroupVC() {
		searchGroupController.groupListVC = self
		self.navigationController?.pushViewController(searchGroupController, animated: true)
	}
}
