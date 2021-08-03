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
    
    var friends = [FriendModel(name: "Pavel", isOnline: true, avatarPath: "1"),
                   FriendModel(name: "Lolita", isOnline: false, avatarPath: "2"),
                   FriendModel(name: "Ivan", isOnline: true, avatarPath: "3"),
                    FriendModel(name: "Maria", isOnline: true, avatarPath: "4"),
                    FriendModel(name: "Olga", isOnline: false, avatarPath: "5"),
                    FriendModel(name: "Svetlana", isOnline: true, avatarPath: "6"),
                    FriendModel(name: "Mikhail", isOnline: false, avatarPath: "7"),
                    FriendModel(name: "Kristina", isOnline: true, avatarPath: "1"),
                    FriendModel(name: "Zinaida", isOnline: false, avatarPath: "2"),
                    FriendModel(name: "Oksana", isOnline: false, avatarPath: "3"),
                    FriendModel(name: "Sergey", isOnline: true, avatarPath: "4"),
                    FriendModel(name: "Alexandr", isOnline: true, avatarPath: "5"),
                    FriendModel(name: "Alexandra", isOnline: true, avatarPath: "6"),
                    FriendModel(name: "Vadim", isOnline: false, avatarPath: "7"),
                    FriendModel(name: "Nastya", isOnline: true, avatarPath: "1"),
                    FriendModel(name: "Vera", isOnline: true, avatarPath: "2"),
                    FriendModel(name: "Denis", isOnline: true, avatarPath: "3"),
                    FriendModel(name: "Ilya", isOnline: true, avatarPath: "4"),
                    FriendModel(name: "Alena", isOnline: true, avatarPath: "5"),
                    FriendModel(name: "Ira", isOnline: true, avatarPath: "6"),
                    FriendModel(name: "Maxim", isOnline: true, avatarPath: "7"),
                    FriendModel(name: "Liza", isOnline: true, avatarPath: "1")]
   
    //создание секции, применимой только к друзьям
    var friendsSection = [Sections<FriendModel>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.friendsCellIdentifier)
        self.navigationItem.title = "Друзья"
        
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
    
}
