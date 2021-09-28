//
//  NewsPhotoCollectionViewCell.swift
//  Study
//
//  Created by Лолита on 23.09.2021.
//

import UIKit

class NewsPhotoCollectionViewCell: UICollectionViewCell {
    
    var photo = UIImageView()
    static let newsPhotoCellIdentifier = "NewsPhotoIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(photo)
        photo.image = UIImage(named: "persik1")
        
        photo.snp.makeConstraints { (maker) in
            maker.trailing.leading.bottom.top.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
