//
//  RowLayout.swift
//  Study
//
//  Created by Лолита Чернышева on 23.11.2021.
//

import Foundation
import UIKit

protocol RowLayoutDelegate: class {
    func collectionView(collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

class RowLayout: UICollectionViewLayout {
    
    weak var delegate: RowLayoutDelegate!
    
    fileprivate var numbersOfRows = 1
    fileprivate var cellPadding: CGFloat = 8
    fileprivate var cache = [UICollectionViewLayoutAttributes]() //массив для кэширования вычисляемых атрибутов
    fileprivate var contentWidth: CGFloat = 0
    fileprivate var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        var photos = [CGSize]()
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView: collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }
        
        let superViewWidth = collectionView.frame.width
        guard let rowHeight = self.rowHightCounter(superViewWidth: superViewWidth, photosArray: photos) else { return }
        
    }
    
    private func rowHightCounter(superViewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
        var rowHeight: CGFloat
        let photoWidhtMinRatio = photosArray.min { (first, second) -> Bool in
            (first.height / first.width) < (second.height / second.width)
        }
        guard let myPhotoWidhtMinRatio = photoWidhtMinRatio else { return nil }
        let difference = superViewWidth / myPhotoWidhtMinRatio.width
        rowHeight = myPhotoWidhtMinRatio.height * difference
        return rowHeight
    }
    
    
}
