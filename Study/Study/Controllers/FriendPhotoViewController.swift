//
//  FriendPhotoViewController.swift
//  Study
//
//  Created by Lola Chernysheva on 27.07.2021.
//

/* MARK: -TODO
	-переписать кострейнты (или вынести константы)
	- натсроить отображение фотографии на коллекции в зависимости от фото в ячейке таблицы
    - добавить реализацию кнопки лайк со счетчиком
*/
import UIKit
import SnapKit

class FriendPhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	
	private var collectionView: UICollectionView?
	private let reuseIdentifier: String = "ReuseIdentifier"
	private let photoImageView: UIImageView? = UIImageView(image: UIImage(named: "VK"))
	
	override func viewDidLoad() {
		super.viewDidLoad()
		initialize()
        updateNavigationItem()
		collectionView?.delegate = self
		collectionView?.dataSource = self
	}
	
	//MARK: - DATA SOURCE
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
		cell.addSubview((photoImageView ?? photoImageView)!)
		photoImageView?.snp.makeConstraints { maker in
			maker.top.equalToSuperview()
			maker.bottom.equalToSuperview()
			maker.trailing.equalToSuperview()
			maker.leading.equalToSuperview()
		}
		return cell
	}
	
	//настройка collectionView
	private func initialize() {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 100.0
		layout.minimumInteritemSpacing = 10.0
		layout.itemSize = CGSize(width: self.view.frame.width, height: (self.view.frame.height)/2)
		layout.scrollDirection = .vertical
		
		collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
		guard let collectionView = collectionView else { return }
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		view.backgroundColor = AppAppearence.backgroundColor
		view.addSubview(collectionView)
		collectionView.backgroundColor = AppAppearence.backgroundColor
		collectionView.snp.makeConstraints { maker in
			maker.top.equalToSuperview()
			maker.trailing.equalToSuperview()
			maker.leading.equalToSuperview()
			maker.bottom.equalToSuperview()
		}
	}
    
    private func updateNavigationItem() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
}
