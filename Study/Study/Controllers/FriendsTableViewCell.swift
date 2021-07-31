//
//  FriendsTableViewCell.swift
//  Study
//
//  Created by Лолита on 30.07.2021.
//

import UIKit
import SnapKit

class FriendsTableViewCell: UITableViewCell {

    private var friendName = UILabel()
    private var friendAvatar = UIImageView()
    static let friendsCellIdentifier = "FriendsCellIdentifier"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.orange
        contentView.addSubview(friendName)
        contentView.addSubview(friendAvatar)
        
        
        
        
        friendAvatar.snp.makeConstraints { (maker) in
            maker.top.bottom.equalToSuperview()
            maker.leading.equalToSuperview().inset(5)
    
            
        }
        friendAvatar.image = UIImage(named: "VK")
        
        
        friendName.snp.makeConstraints { (maker) in
            maker.top.bottom.equalToSuperview()
            maker.leading.equalTo(friendAvatar).inset(5)
           
        }
         friendName.text = "fgchvjbjn"
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    

}
