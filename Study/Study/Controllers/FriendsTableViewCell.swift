//
//  FriendsTableViewCell.swift
//  Study
//
//  Created by Лолита on 30.07.2021.
//

import UIKit
import SnapKit

class FriendsTableViewCell: UITableViewCell {

    var friendName = UILabel()
    var friendAvatar = AvatarView()
    static let friendsCellIdentifier = "FriendsCellIdentifier"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = AppAppearence.backgroundColor
        contentView.addSubview(friendName)
        contentView.addSubview(friendAvatar)

        friendAvatar.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().inset(5)
            maker.width.height.equalTo(50)
        }
        
        friendName.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(friendAvatar.snp.trailing)
            maker.trailing.equalToSuperview().inset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
