//
//  NewsTableViewCell.swift
//  Study
//
//  Created by Лолита on 20.09.2021.
//

/*MARK:- todo
 -поменять цвета у лэйблов
 */

import UIKit
import SnapKit

class NewsTableViewCell: UITableViewCell {
    
    var avatarView = AvatarView()
    var nameLabel = UILabel()
    var dateLabel = UILabel()
    var descriptionLabel = UILabel()
    var newsPhotos = UICollectionView()
    
    static let newsCellIdentifier = "NewsCellIdentifier"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private
    
    private func initialize() {
        
        avatarView.avatarImageView.contentMode = .scaleAspectFill
        nameLabel.numberOfLines = 0
        dateLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
        
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(newsPhotos)
        
        avatarView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().inset(5)
            maker.top.equalToSuperview().inset(5)
            maker.width.height.equalTo(50)
            
        }
        nameLabel.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(5)
            maker.trailing.equalToSuperview().inset(5)
            maker.leading.equalTo(avatarView).inset(53)
            maker.height.equalTo(20)
            
        }
        dateLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(nameLabel).inset(23)
            maker.trailing.equalToSuperview().inset(5)
            maker.leading.equalTo(avatarView).inset(53)
            maker.height.equalTo(20)
        }
        
        descriptionLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(avatarView).inset(60)
            maker.leading.equalToSuperview().inset(5)
            maker.trailing.equalToSuperview().inset(5)
            maker.bottom.equalToSuperview().inset(5)
        }
    }
}
