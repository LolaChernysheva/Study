//
//  AvatarView.swift
//  Study
//
//  Created by Лолита on 30.07.2021.
//

/*MARK: - TODO
 обработать опционал
 
 */

import UIKit

class AvatarView: UIView {
    
    var avatarImageView: UIImageView!
    
    //конструктор инит frame отвечает за формирование класса с помощью кода
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImage()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addImage() {
        avatarImageView = UIImageView(frame: frame)
        addSubview(avatarImageView)
    }
    
    // для сохранения пропорций
    override func layoutSubviews() {
        //обновление размеров картинки
        avatarImageView.frame = bounds
        
        layer.backgroundColor = UIColor.clear.cgColor
//        //настройка тени
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 1.0
//        layer.shadowRadius = 4.0
//        layer.shadowOffset = CGSize(width: 0, height: 1)
        
        //закругляем картинку
        avatarImageView.layer.cornerRadius = bounds.size.height/2
        avatarImageView.layer.masksToBounds = true
        
    }


}
