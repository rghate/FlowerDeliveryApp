//
//  ShopCell.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 22/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit
import Cosmos

@objc protocol ShopCellDelegate: class {
    func didTapOnSend()
    
    @objc optional func didTapOnProductImage()
    @objc optional func didTapOnRatings()
    @objc optional func didTapOnReviews()
    @objc optional func didTapOnSave(isSaved: Bool)
    @objc optional func didTapOnProductTitle()
}


class ShopCell: UICollectionViewCell {
    
    // MARK: Public properties
    
    weak var delegate: ShopCellDelegate?
    
    var product: ProductViewModel? {
        didSet {
            if let product = product {
                DispatchQueue.main.async { [weak self] in
                    
                    // update product title and type
                    self?.titleLabel.text = product.attributes.name
                    self?.typeLabel.text = product.attributes.collectionName
                    
                    // update review
                    let reviewCount = product.attributes.ratingCount > 0 ? "\(product.attributes.ratingCount)" : "No"
                    self?.reviewsLabel.text = "\(reviewCount) reviews"
                    
                    // update rating
                    if let rating = product.attributes.ratingAverage {
                        self?.ratingView.rating = rating
                    }
                    
                    // display pre order message
                    if let message = product.preOrderMessage {
                        self?.messageLabel.attributedText = message
                        self?.messageLabel.isHidden = false
                    } else {
                        self?.messageLabel.isHidden = true
                    }
                    
                    // load carousel images
                    self?.imageUrls.removeAll()
                    self?.imageUrls = product.mediaUrls
                    self?.carouselView.imageUrls = product.mediaUrls
                }
            }
            
        }
    }
    
    var imageScale: CGFloat = 1
    
    var isFirstCell: Bool = false {
        didSet {
            carouselView.shouldAnimate = isFirstCell
        }
    }
    
    // MARK: Private properties
    
    //    private var imageUrls: [URL] = [     URL(string: "https:assets-0.bloomandwild.com/letterbox-main/the-gabrielle-ht-charbonnel/c835a5a4-6643-49d3-a1b4-7ecbd79ece7e.jpg")!,
    //                                         URL(string: "https:assets-0.bloomandwild.com/addon-carousel/the-gabrielle-ht-charbonnel/928523ab-a2ed-4ce6-9dd9-7304d07405c7.jpg")!,
    //                                         URL(string: "https:assets-0.bloomandwild.com/addon-carousel/bouquet/0709a586-5eac-4b91-bd5f-b05de8bb2227.jpeg")!,
    //                                         URL(string: "https:assets-0.bloomandwild.com/addon-carousel/the-gabrielle-ht-charbonnel/abc3876c-58be-4ae8-85f0-7e2352ab4ac0.jpeg")!,
    //                                         URL(string: "https:assets-0.bloomandwild.com/addon-carousel/bouquet/5a84277e-63c6-4dfd-9584-657d02c2bb1f.jpg")!]
    
    private var imageUrls: [URL] = [URL]()
    
    private lazy var gradientBar: UIView = {
        let view = UIView()
        let imageView = UIImageView()
        if let image = UIImage(named: "gradientBottom") {
            imageView.image = image
        }
        view.addSubview(imageView)
        imageView.fillSuperview()
        imageView.tintColor = .white
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        //        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        //        label.text = "Letterbox Flowers"
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .left
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        //        label.text = "£30"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var imageWidth: CGFloat = self.frame.width
    
    private lazy var favoriteButton: FloatingButton = {
        let button = FloatingButton(frame: .init(x: 0, y: 0, width: 40, height: 40), withRadius: 20)
        button.backgroundColor = Color.SECONDARY_BACKGROUND_COLOR
        button.setImage(self.favoriteImageEmpty?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.tintColor = Color.PRIMARY_ACCENT_COLOR
        button.showShadow = false
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        
        return button
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        //        label.text = "order now for deliver from 24th September"
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        label.backgroundColor = Color.SECONDARY_ACCENT_COLOR
        label.isHidden = false
        return label
    }()
    
    
    private let ratingView: CosmosView = {
        let view = CosmosView()
        view.rating = 0
        view.settings.fillMode = .precise
        view.settings.updateOnTouch = false
        view.settings.emptyBorderColor = .orange
        view.settings.emptyColor = .clear
        view.settings.filledBorderColor = .orange
        view.settings.filledColor = .orange
        view.settings.starSize = 28
        
        return view
    }()
    
    private let reviewsLabel: UILabel = {
        let label = UILabel()
        label.text = "252 reviews"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private let sendButton: FlatButton = {
        let button = FlatButton(withTitle: "send")
        return button
    }()
    
    private lazy var carouselView = CarouselView()
    
    let favoriteImageEmpty = UIImage(named: "saved")
    let favoriteImageFilled = UIImage(named: "saved_selected")
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Color.SECONDARY_BACKGROUND_COLOR
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        // TODO: reset cell data here
        favoriteButton.imageView?.image = nil
    }

    
    
    // MARK: Handlers
    
    @objc func handleSend() {
        print("Handle send")
        delegate?.didTapOnSend()
    }
    
    @objc func handleSave() {
        print("handle save")
        let  wasPreviouslyFavorite = isFavorite()
        let image =  wasPreviouslyFavorite == true ? favoriteImageEmpty : favoriteImageFilled
        favoriteButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)

        delegate?.didTapOnSave?(isSaved: !wasPreviouslyFavorite)
    }

    @objc func handleReviewsTapGesture(_ sender: UITapGestureRecognizer) {
        print("Review tap gesture recognizer handler")
        delegate?.didTapOnReviews?()
    }
    
    @objc func handleTitleSelection() {
        print("Handle title select")
        delegate?.didTapOnProductTitle?()
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
        let scrollView = UIScrollView()
        addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.showsVerticalScrollIndicator = false
        //        scrollView.delaysContentTouches = false
        
        
        // carousel view for displaying all the images related to the product
        scrollView.addSubview(carouselView)
        carouselView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: imageWidth, height: imageWidth * imageScale))
        
        carouselView.delegate = self
        
        
        // gradient bar
        scrollView.addSubview(gradientBar)
        gradientBar.anchor(top: carouselView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: -100, left: 0, bottom: 0, right: 0), size: .init(width: frame.width, height: 150))
        
        
        // message label
        gradientBar.addSubview(messageLabel)
        messageLabel.anchor(top: gradientBar.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 70, left: 0, bottom: 0, right: 0), size: .init(width: frame.width, height: 30))
        
        
        // product name label
        gradientBar.addSubview(titleLabel)
        titleLabel.anchor(top: gradientBar.topAnchor, leading: gradientBar.leadingAnchor, bottom: nil, trailing: gradientBar.trailingAnchor, padding: .init(top: 110, left: 16, bottom: 0, right: 16))
        titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTitleSelection)))
        
        
        // product type label
        gradientBar.addSubview(typeLabel)
        typeLabel.anchor(top: titleLabel.bottomAnchor, leading: gradientBar.leadingAnchor, bottom: nil, trailing: gradientBar.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16))
        
        
        // price label
        scrollView.addSubview(priceLabel)
        priceLabel.anchor(top: typeLabel.bottomAnchor, leading: typeLabel.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 100))
        
        
        // favorite (save) button
        scrollView.addSubview(favoriteButton)
        favoriteButton.anchor(top: nil, leading: nil, bottom: priceLabel.bottomAnchor, trailing: scrollView.trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: 0, right: 16))
        
        // ratings
        scrollView.addSubview(ratingView)
        ratingView.anchor(top: gradientBar.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 150, left: 0, bottom: 0, right: 0))
        ratingView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        // reviews label
        scrollView.addSubview(reviewsLabel)
        reviewsLabel.anchor(top: ratingView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor,  padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        reviewsLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor).isActive = true
        reviewsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleReviewsTapGesture(_:))))
        
        
        // send button
        scrollView.addSubview(sendButton)
        sendButton.anchor(top: reviewsLabel.bottomAnchor, leading: nil, bottom: scrollView.bottomAnchor, trailing: nil,
                          padding: .init(top: 30, left: 0, bottom: 20, right: 0),
                          size: .init(width: 100, height: 40))
        sendButton.centerXAnchor.constraint(equalTo: reviewsLabel.centerXAnchor).isActive = true
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
    }
    
    private func isFavorite() -> Bool {
        favoriteButton.imageView?.image == favoriteImageEmpty ? false : true
    }
}


// MARK: Extensions
extension ShopCell: CarouselViewDelegate {
    func carouselViewOnSelect(index: Int) {
        print("Image selected at index: \(index)")
        delegate?.didTapOnProductImage?()
    }
}

