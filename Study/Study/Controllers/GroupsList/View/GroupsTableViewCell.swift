//
//  GroupsTableViewCell.swift
//  Study
//
//  Created by Лолита on 03.08.2021.
//

import UIKit
import SnapKit

class GroupsTableViewCell: UITableViewCell {

    var groupName = UILabel()
    var groupAvatar = AvatarView()
    
    static let groupsCellIdentifier = "GroupsCellIdentifier"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = AppAppearence.backgroundColor
        contentView.addSubview(groupName)
        contentView.addSubview(groupAvatar)
        
        groupAvatar.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().inset(5)
            maker.width.height.equalTo(50)
        }
        
        groupName.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(groupAvatar.snp.trailing).inset(-5)
            maker.trailing.equalToSuperview().inset(-5)
        }
        groupAvatar.avatarImageView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
