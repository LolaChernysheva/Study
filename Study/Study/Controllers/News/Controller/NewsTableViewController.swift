//
//  NewsTableViewController.swift
//  Study
//
//  Created by Лолита on 20.09.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
 
    var newsList = [NewsModel(nameOfCreator: "Пикабу", dateOfCreation: "11.02.2021", description: "sdfghjkljkhjghfgdghjkhghfvhjfgcnhjgf"),
                    NewsModel(nameOfCreator: "Питер Онлайн", dateOfCreation: "14.07.2021", description: "hgyh"),
                    NewsModel(nameOfCreator: "Иван Иванов", dateOfCreation: "11.08.2021", description: "sdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgf"),
                    NewsModel(nameOfCreator: "Петр Петров", dateOfCreation: "08.09.2021", description: "sdfghjkljkhjghfg"),
                    NewsModel(nameOfCreator: "Мария Иванова", dateOfCreation: "11.02.2021", description: "sdfghjkljkhjghfgdghjkhghfvsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhjfgcnhjgf"),
                    NewsModel(nameOfCreator: "Дарья Николаева", dateOfCreation: "15.04.2021", description: "sdfghjkljkhjgghfvhjfgcnhjgf"),
                    NewsModel(nameOfCreator: "Анастасия смирнова", dateOfCreation: "23.04.2021", description: "sdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfvvvsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgfsdfghjkljkhjghfgdghsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfsdfghjkljkhjghfgdghjkhghfvhjfgcnhjgfhfvhjfgcnhjgf")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.newsCellIdentifier)
        
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableView.automaticDimension


    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.newsCellIdentifier, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = newsList[indexPath.row].nameOfCreator
        cell.avatarView.avatarImageView.image = UIImage(named: "persik1")
        cell.dateLabel.text = newsList[indexPath.row].dateOfCreation
        cell.descriptionLabel.text = newsList[indexPath.row].description
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
