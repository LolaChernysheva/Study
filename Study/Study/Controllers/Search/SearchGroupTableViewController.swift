//
//  SearchGroupTableViewController.swift
//  Study
//
//  Created by admin on 28.07.2021.
//

//MARK:- TODO
//в метод addElement добавить элемент не в исхожный массив, а в уже структурированный:
// - определить секцию, положить туда элемент, обновить секцию или сам элемент

import UIKit

class SearchGroupTableViewController: UITableViewController {

    var groupListVC: GroupsListTableViewController?
    
	public var groupToAdd = [GroupModel(groupName: "апро", avatarPath: "persik1"),
                             GroupModel(groupName: "сми", avatarPath: "persik3")]
    
    var groupsSection = [Sections<GroupModel>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.groupsCellIdentifier)
		initialize()
        configureSections()

    }

    // MARK: - Table view data source

    //отображение секции
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupsSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsSection[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupsSection[section].title
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    ///реализация боковой плашки с алфавитом
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return groupsSection.map { $0.title }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = AppAppearence.backgroundColor
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		 guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.groupsCellIdentifier, for: indexPath) as? GroupsTableViewCell else { return UITableViewCell() }
        cell.groupName.text = groupsSection[indexPath.section].items[indexPath.row].groupName
        cell.groupAvatar.avatarImageView.image = UIImage(named: groupsSection[indexPath.section].items[indexPath.row].avatarPath)
		return cell
	}
	
	//добавление новой группы по клику на ячейку
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let removingElement = groupsSection[indexPath.section].items[indexPath.row]
        groupListVC?.addElement(removingElement)
        groupsSection[indexPath.section].items.remove(at: indexPath.row)

        if  groupsSection[indexPath.section].items.count == 0 {
            groupsSection.remove(at: indexPath.section)
            tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
        } else {
            tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
        }
	}

	private func initialize() {
		self.modalPresentationStyle = .fullScreen
		view.backgroundColor = AppAppearence.backgroundColor
	}
    
    func configureSections() {
        //создание словаря из массива и группировкой по первому символу name
        let groupsDictionary = Dictionary.init(grouping: groupToAdd) {
            $0.groupName.prefix(1)
        }
        //конвертация словаря в секцию с заголовком и элементами
        groupsSection = groupsDictionary.map { Sections(title: String($0.key), items: $0.value) }
        //сортировка секций по алфавиту
        groupsSection.sort { $0.title < $1.title }
    }
    
    func addElement(_ element: GroupModel) {
        groupToAdd.append(element)
        configureSections()
        tableView.reloadData()
    }
}
