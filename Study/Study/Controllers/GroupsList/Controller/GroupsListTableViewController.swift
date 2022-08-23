//
//  GroupsListTableViewController.swift
//  Study
//
//  Created by Lola Chernysheva on 20.07.2021.
//



import UIKit

class GroupsListTableViewController: UITableViewController {
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
	lazy var searchGroupController = SearchGroupTableViewController()
    
    var groupsList = [GroupModel(groupName: "Pikabu", avatarPath: "persik1"),
                      GroupModel(groupName: "Вконтакте", avatarPath: "persik2"),
                      GroupModel(groupName: "Питер", avatarPath: "persik3"),
                      GroupModel(groupName: "Москва", avatarPath: "persik1"),
                      GroupModel(groupName: "Саратов", avatarPath: "persik2"),
                      GroupModel(groupName: "Воронеж", avatarPath: "persik3"),
                      GroupModel(groupName: "Ростов", avatarPath: "persik1"),
                      GroupModel(groupName: "Севастополь", avatarPath: "persik2"),
                      GroupModel(groupName: "Алушта", avatarPath: "persik3"),
                      GroupModel(groupName: "Хабаровск", avatarPath: "persik1"),
                      GroupModel(groupName: "Красноярск", avatarPath: "persik2"),
                      GroupModel(groupName: "Калининград", avatarPath: "persik3"),
                      GroupModel(groupName: "Днепропетровск", avatarPath: "persik1"),
                      GroupModel(groupName: "Киров", avatarPath: "persik2"),
                      GroupModel(groupName: "Вологда", avatarPath: "persik3"),
                      GroupModel(groupName: "Анапа", avatarPath: "persik1"),
                      GroupModel(groupName: "Абакан", avatarPath: "persik2"),
                      GroupModel(groupName: "Нур-Султан", avatarPath: "persik3")]
    
    var groupsSection = [Sections<GroupModel>]()
    let searchController = UISearchController()

    //MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        fetcher.getGroups { groupResponse in
            guard let groupResponse = groupResponse else {
                return
            }
            groupResponse.items.map { group in
              //  print(group.name)
            }
        }
        
        fetcher.getPhotos { photosResponse in
            guard let photosResponse = photosResponse else {
                return
            }
            print("ФОТО\(photosResponse)")

        }
    }
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.groupsCellIdentifier)
        self.navigationItem.title = "Сообщества"
		initialize()
        configureSearchBar()
        configureSections()
        searchController.searchBar.delegate = self

    }

    // MARK: - Table view

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
	
    //реализация боковой плашки с алфавитом
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
	
	//удаление ячейки
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		switch editingStyle {
		case .delete:
            let removingElement = groupsSection[indexPath.section].items[indexPath.row]
            searchGroupController.addElement(removingElement)
            groupsSection[indexPath.section].items.remove(at: indexPath.row)

            if  groupsSection[indexPath.section].items.count == 0 {
                groupsSection.remove(at: indexPath.section)
                tableView.reloadData()
            } else {
                tableView.reloadData()
            }
		default:
			return
		}
	}
    
    //MARK: - public

    func configureSections() {
        //создание словаря из массива и группировкой по первому символу name
        let groupsDictionary = Dictionary.init(grouping: groupsList) {
            $0.groupName.prefix(1)
        }
        //конвертация словаря в секцию с заголовком и элементами
        groupsSection = groupsDictionary.map { Sections(title: String($0.key), items: $0.value) }
        //сортировка секций по алфавиту
        groupsSection.sort { $0.title < $1.title }
    }
    
    func addElement(_ element: GroupModel) {
        groupsList.append(element)
        configureSections()
        tableView.reloadData()
    }
	
     //MARK: - private
    
	private func initialize() {
		view.backgroundColor = AppAppearence.backgroundColor
		self.modalPresentationStyle = .fullScreen
		let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(goToSearchGroupVC))
		self.navigationItem.rightBarButtonItem = rightButton
	}
    
    private func configureSearchBar() {
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
    }
	
	//переход на экран поиска
	@objc private func goToSearchGroupVC() {
		searchGroupController.groupListVC = self
		self.navigationController?.pushViewController(searchGroupController, animated: true)
	}
}

//MARK:-UISearchBarDelegate

extension GroupsListTableViewController: UISearchBarDelegate {
    //отрабатывает каждый раз, когда происходит модификация внутри searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let groupsDictionary = Dictionary.init(grouping: groupsList.filter { (group) -> Bool in
            return searchText.isEmpty ? true : group.groupName.lowercased().contains(searchText.lowercased())
        }) { $0.groupName.prefix(1) }
        groupsSection = groupsDictionary.map { Sections(title: String($0.key), items: $0.value) }
        groupsSection.sort { $0.title < $1.title }
        tableView.reloadData()
        print(searchText)
    }
    
    //отработает при нажатии на кнопку поиска
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //окончание редактирования. Позволяет скрыть клавиатуру
        view.endEditing(true)
    }
}
