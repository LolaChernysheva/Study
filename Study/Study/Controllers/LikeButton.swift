//
//  LikeButton.swift
//  Study
//
//  Created by Лолита on 02.08.2021.
//

import UIKit

class LikeButton: UIButton {
    var liked: Bool = false
    
    var likeCount = 0
    
    func like() {
        liked != liked
        
        if liked {
            setLike()
        } else {
            setDisliked()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpDefault() {
        setImage(UIImage(named: "dislike"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        
        /*
         настроим размеры изображения
         раскоментировать при необходимости
         imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
         titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
         imageView?.contentMode = .scaleAspectFit
         */
        
    }
    
    private func setLike() {
        likeCount += 1
        setImage(UIImage(named: "like"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
    }
    
    private func setDisliked() {
        likeCount -= 1
        setImage(UIImage(named: "dislike"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
    }
}
