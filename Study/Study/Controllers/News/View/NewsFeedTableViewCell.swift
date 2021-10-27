//
//  NewsFeedTableViewCell.swift
//  Study
//
//  Created by Лолита Чернышева on 19.10.2021.
//

import UIKit

final class NewsFeedTableViewCell: UITableViewCell {
    
    static let reusedId = "NewsFeedTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
