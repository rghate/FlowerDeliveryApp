//
//  CarouselCell.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 23/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {
 
    // MARK: Public properties

    var imageUrl: URL? {
        didSet {
            if let url = imageUrl {
                self.imageView.loadImage(with: url)
            }
        }
    }
    
    
    // MARK: Private properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    // MARK: Private functions
    
    private func setupViews() {
        backgroundColor = Color.SECONDARY_BACKGROUND_COLOR

        addSubview(imageView)
        imageView.fillSuperview()
    }
    
}
