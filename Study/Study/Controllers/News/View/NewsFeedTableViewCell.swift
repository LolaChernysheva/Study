//
//  NewsFeedTableViewCell.swift
//  Study
//
//  Created by Лолита Чернышева on 19.10.2021.
//

import UIKit

final class NewsFeedTableViewCell: UITableViewCell {
    
    static let reusedId = "NewsFeedTableViewCell"
    
    //Первый слой элементов
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .magenta
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Второй слой элементов
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        label.backgroundColor = .yellow
        return label
        
    }()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        overlayFirstLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Первый слой элементов
    private func overlayFirstLayer() {
        addSubview(cardView)
        cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    //Второй слой элементов
    private func overlaySecondLayer() {
        
    }
    

}
