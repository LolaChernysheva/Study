//
//  FriendPhotoViewController.swift
//  Study
//
//  Created by admin on 27.07.2021.
//

import UIKit
import SnapKit

class FriendPhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	
	private var collectionView: UICollectionView?
	private let reuseIdentifier: String = "ReuseIdentifier"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 10.0
		layout.minimumInteritemSpacing = 10.0
		layout.itemSize = CGSize(width: 100.0, height: 100.0)
		layout.scrollDirection = .vertical
		
		collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
		guard let collectionView = collectionView else { return }
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		initialize()
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
		cell.backgroundColor = .magenta
		return cell
	}
	
	private func initialize() {
		guard let collectionView = collectionView else { return }
		view.backgroundColor = AppAppearence.backgroundColor
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { maker in
			maker.top.equalToSuperview()
			maker.trailing.equalToSuperview()
			maker.leading.equalToSuperview()
			maker.bottom.equalToSuperview()
		}
		
	}

}
