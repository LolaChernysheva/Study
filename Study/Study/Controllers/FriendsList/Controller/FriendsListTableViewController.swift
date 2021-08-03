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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.friendsCellIdentifier)
        updateNavigationBar()
        
        
        //создание словаря из массива и группировкой по первому символу name
        let friendsDictionary = Dictionary.init(grouping: friends) {
            $0.name.prefix(1)
        }
        //конвертация словаря в секцию с заголовком и элементами
        friendsSection = friendsDictionary.map { Sections(title: String($0.key), items: $0.value) }
        //сортировка секций по алфавиту
        friendsSection.sort { $0.title < $1.title }
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
    
    private func updateNavigationBar() {
        self.navigationItem.title = "Друзья"
        //self.navigationController?.navigationBar.barTintColor = AppAppearence.customBlue
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = AppAppearence.backgroundColor
    }
    
}
