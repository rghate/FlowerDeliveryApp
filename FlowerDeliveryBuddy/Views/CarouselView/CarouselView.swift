//
//  ImageScrollerView.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 22/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//


import UIKit
import SDWebImage

protocol CarouselViewDelegate: class {
    func carouselViewOnSelect(index: Int)
}

class CarouselView: UIView {
    
    // MARK: Public properties
    
    weak var delegate: CarouselViewDelegate?
    
    var imageUrls: [URL] = [URL]() {
        didSet {
            // prefetch product images for the carousel
            SDWebImagePrefetcher.shared.prefetchURLs(imageUrls, progress: nil, completed: { [weak self] finishedCount, skippedCount in
                guard let self = self else { return }
                self.collectionView.reloadData()
                self.scrollToTop()
                
                if self.shouldAnimate {
                    self.animateFirstImage()
                }
            })
            
        }
    }

    var shouldAnimate: Bool = false
    
    
    // MARK: Private properties
    
    private var downloadedImages: [UIImage] = [UIImage]()
    
    private let cellId = "cellId"
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = true
        collectionView.contentInsetAdjustmentBehavior = .never
        
        return collectionView
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Handlers
    
    // MARK: Private methods
    
    private func setupViews() {
        addSubview(collectionView)
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.fillSuperview()
        collectionView.backgroundColor = Color.SECONDARY_BACKGROUND_COLOR
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func scrollToTop() {
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }
    
    /**
     Animates first cell of the collection view as an indicator to user that the collectionview is scrollable to view rest fo the collectionview images.
     */
    private func animateFirstImage() {
        guard shouldAnimate else { return }
//                guard self.collectionView.visibleCells.count > 0 else { return }
        
        let verticalOffset: CGFloat = 50
        let duration = TimeInterval(2) // in seconds
        let initialDelay = TimeInterval(1) // in seconds
        let springDamping: CGFloat = 0.6
        let springVelocity: CGFloat = 1
        
        UIView.animate(withDuration: duration, delay: initialDelay, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: .curveEaseIn, animations: {
            // scroll first cell up by the specified verticalOffset (in this case - 50) for the specified duration (in this case - 2 seeconds)
            self.collectionView.scrollRectToVisible(CGRect(x: 0, y: verticalOffset, width: self.frame.width, height: self.frame.height), animated: false)
            
        }, completion: { _ in
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: springVelocity, options: .curveEaseOut, animations: { [weak self] in
                
                // scroll back to first cell
                self?.collectionView.scrollToItem(at: .init(item: 0, section: 0), at: .bottom, animated: false)
                }, completion: nil)
        })
    }
}


// MARK: Extensions

extension CarouselView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CarouselCell else {
            fatalError("Error: ImageCarouselCell not found")
        }
        
        cell.imageUrl = imageUrls[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.carouselViewOnSelect(index: indexPath.row)
    }
}
