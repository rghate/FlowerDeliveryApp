//
//  BaseCollectionView.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 24/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class BaseCollectionView: UICollectionView {
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(), scrollDirection: UICollectionView.ScrollDirection) {
        
        layout.scrollDirection = scrollDirection
        layout.minimumLineSpacing = 0

        super.init(frame: frame, collectionViewLayout: layout)

        showsHorizontalScrollIndicator = false
        contentInsetAdjustmentBehavior = .never
        isPagingEnabled = true
        bounces = true
        
        backgroundColor = Color.SECONDARY_BACKGROUND_COLOR
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
        }
    }
    
    func scrollToTop() {
        self.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }
    
}
