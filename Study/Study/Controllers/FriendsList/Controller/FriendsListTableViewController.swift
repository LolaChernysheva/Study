//
//  FriendsListTableViewController.swift
//  Study
//
//  Created by Lola Chernysheva on 20.07.2021.
//

import UIKit

class FriendsListTableViewController: UITableViewController {

    var friends = [FriendModel(name: "Павел Чернышев", isOnline: true, avatarPath: "1"),
                   FriendModel(name: "Лолита Чернышева", isOnline: false, avatarPath: "2"),
                   FriendModel(name: "Иван Иванов", isOnline: true, avatarPath: "3"),
                    FriendModel(name: "Мария Иванова", isOnline: true, avatarPath: "4"),
                    FriendModel(name: "Ольга Петрова", isOnline: false, avatarPath: "5"),
                    FriendModel(name: "Светлана Петрова", isOnline: true, avatarPath: "6"),
                    FriendModel(name: "Михаил Иванов", isOnline: false, avatarPath: "7"),
                    FriendModel(name: "Кристина Сидорова", isOnline: true, avatarPath: "1"),
                    FriendModel(name: "Зинаида Зинина", isOnline: false, avatarPath: "2"),
                    FriendModel(name: "Оксана Михайлова", isOnline: false, avatarPath: "3"),
                    FriendModel(name: "Сергей Петров", isOnline: true, avatarPath: "4"),
                    FriendModel(name: "Александр Чернышев", isOnline: true, avatarPath: "5"),
                    FriendModel(name: "Александра Даниленко", isOnline: true, avatarPath: "6"),
                    FriendModel(name: "Вадим Андреев", isOnline: false, avatarPath: "7"),
                    FriendModel(name: "Аеастасия Александрова", isOnline: true, avatarPath: "1"),
                    FriendModel(name: "Вера Игнатьева", isOnline: true, avatarPath: "2"),
                    FriendModel(name: "Денис Воробьев", isOnline: true, avatarPath: "3"),
                    FriendModel(name: "Илья Сергеев", isOnline: true, avatarPath: "4"),
                    FriendModel(name: "Алена Иванова", isOnline: true, avatarPath: "5"),
                    FriendModel(name: "Ирина Андреева", isOnline: true, avatarPath: "6"),
                    FriendModel(name: "Максим Максимов", isOnline: true, avatarPath: "7"),
                    FriendModel(name: "Елизавета Вадимова", isOnline: true, avatarPath: "1")]
   
    //создание секции, применимой только к друзьям
    var friendsSection = [Sections<FriendModel>]()
    var customRefreshControl = UIRefreshControl()
    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.friendsCellIdentifier)
        updateNavigationBar()
        configureSections()
        configureSearchBar()
        configureRefreshControl()
        searchController.searchBar.delegate = self
    }
    
    //отображение секции
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendsSection.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsSection[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendsSection[section].title
    }
    
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.friendsCellIdentifier, for: indexPath) as? FriendsTableViewCell else { return UITableViewCell() }
        cell.friendName.text = friendsSection[indexPath.section].items[indexPath.row].name
        cell.friendAvatar.avatarImageView.image = UIImage(named: friendsSection[indexPath.section].items[indexPath.row].avatarPath)
        return cell
	}
	
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		self.navigationController?.pushViewController(FriendPhotoViewController(), animated: true)
	}
    
    //реализация боковой плашки с алфавитом
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendsSection.map { $0.title }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = AppAppearence.backgroundColor
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var shareAction = UITableViewRowAction(style: .default, title: "Share") { (action, index) in
            print("Shared \(index.section) \(index.row)")}
        var forwardAction = UITableViewRowAction(style: .default, title: "Forward") { (action, index) in
            print("Shared \(index.section) \(index.row)")
        }
        shareAction.backgroundColor = UIColor.yellow
        forwardAction.backgroundColor = UIColor.magenta
        return [shareAction, forwardAction]
    }
    
    private func configureSections() {
        //создание словаря из массива и группировкой по первому символу name
        let friendsDictionary = Dictionary.init(grouping: friends) {
            $0.name.prefix(1)
        }
        //конвертация словаря в секцию с заголовком и элементами
        friendsSection = friendsDictionary.map { Sections(title: String($0.key), items: $0.value) }
        //сортировка секций по алфавиту
        friendsSection.sort { $0.title < $1.title }
    }
    
    private func updateNavigationBar() {
        self.navigationItem.title = "Друзья"
        //self.navigationController?.navigationBar.barTintColor = AppAppearence.customBlue
    }

    private func configureSearchBar() {
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
    }
    
    private func configureRefreshControl() {
        customRefreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.addSubview(customRefreshControl)
    }
    
    @objc private func refreshTable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.customRefreshControl.endRefreshing()
        }
    }

}

//MARK:-UISearchBarDelegate

extension FriendsListTableViewController: UISearchBarDelegate {
    //отрабатывает каждый раз, когда происходит модификация внутри searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let friendsDictionary = Dictionary.init(grouping: friends.filter { (friend) -> Bool in
            return searchText.isEmpty ? true : friend.name.lowercased().contains(searchText.lowercased())
        }) { $0.name.prefix(1) }
        friendsSection = friendsDictionary.map { Sections(title: String($0.key), items: $0.value) }
        friendsSection.sort { $0.title < $1.title }
        tableView.reloadData()
        print(searchText)
    }
    
    //отработает при нажатии на кнопку поиска
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //окончание редактирования. Позволяет скрыть клавиатуру
        view.endEditing(true)
    }
}
