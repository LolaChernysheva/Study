//
//  SearchGroupTableViewController.swift
//  Study
//
//  Created by admin on 28.07.2021.
//

import UIKit

class SearchGroupTableViewController: UITableViewController {

	var groupListVC: GroupsListTableViewController?
	private var groupToAdd = ["GroupAdd1", "GroupAdd2", "AddGroup3"]
    override func viewDidLoad() {
        super.viewDidLoad()
		initialize()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
		return groupToAdd.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = groupToAdd[indexPath.row]
		return cell
	}
	
	//добавление новой группы по клику на ячейку
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let groupListVC = groupListVC else { return }
		groupListVC.groupsList.append(groupToAdd[indexPath.row])
		groupToAdd.remove(at: indexPath.row)
		groupListVC.tableView.reloadData()
		tableView.reloadData()
		self.navigationController?.popViewController(animated: true)
	}

	private func initialize() {
		self.modalPresentationStyle = .fullScreen
		view.backgroundColor = AppAppearence.backgroundColor
	}
}
