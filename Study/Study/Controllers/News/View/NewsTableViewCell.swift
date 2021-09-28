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
        newsPhotos.delegate = self
        newsPhotos.dataSource = self
        initialize()
        collectionInitialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private
    
    private func initialize() {
        
        newsPhotos.backgroundColor = UIColor.yellow
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
            maker.bottom.equalTo(newsPhotos).inset(5)
        }
        newsPhotos.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().inset(5)
            maker.leading.equalToSuperview().inset(5)
            maker.bottom.equalToSuperview().inset(5)
        }
    }
    
    private func collectionInitialize() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        newsPhotos = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        newsPhotos.collectionViewLayout = layout
        newsPhotos.showsHorizontalScrollIndicator = false
        newsPhotos.isPagingEnabled = true
        newsPhotos.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NewsPhotoCollectionViewCell.newsPhotoCellIdentifier)
    }
}

extension NewsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
   
 

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewsPhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsPhotoCollectionViewCell.newsPhotoCellIdentifier, for: indexPath) as! NewsPhotoCollectionViewCell
        
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: kPhotoWidth, height: kPhotoHeight)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt  section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
    }

//    func collectionView(_ collectionView: UICollectionView, layout > collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
