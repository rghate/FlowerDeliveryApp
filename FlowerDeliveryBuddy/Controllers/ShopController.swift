//
//  FirstViewController.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 17/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class ShopController: BaseControlller {
    
    // MARK: Private properties
    
    private lazy var collectionView = BaseCollectionView(frame: .zero, scrollDirection: .horizontal)
    
    private let cellId = "cellId"
    private let footerId = "footerId"
    private var products = [ProductViewModel]()
    private var footerView: CustomFooter?

    private var currentProductIndex: Int?
    
    // MARK: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        // register shop cell
        collectionView.register(ShopCell.self, forCellWithReuseIdentifier: cellId)

        //register footer cell
        collectionView.register(CustomFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)

        collectionView.delegate = self
        collectionView.dataSource = self
        
        downloadProductsData()
    }
    
    
    // MARK: Private functions
    
    private func setupViews() {
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        self.view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,
                              padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    private func showProductDetails() {
        let vc = ProductDetailsController()
        if let currentIndex = currentProductIndex {
            vc.productTitle = products[currentIndex].attributes.name
        }
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    private func downloadProductsData() {
        prepareBeforeDataDownload()
        
        DispatchQueue.global(qos: .background).async {
            
            ProductViewModel.fetchProducts(forCountryId: "1", locale: "en", completion: { result in
                var error: CustomError?
                
                switch result {
                case .failure(let err):
                    print("Error: ", err)
                    error = err
                    
                case .success(let products):
                    print("Success:")
                    self.products = products
                    
                }
                self.prepareAfterDataDownload(err: error)
            })
        }
    }
    
    private func prepareBeforeDataDownload() {
        //show wait indicator
        footerView?.setMessage(withText: "Please wait", visibleWaitIndicator: true)
        
//        products.removeAll()
        
        collectionView.reloadCollectionView()
    }

    private func prepareAfterDataDownload(err: CustomError?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if let err = err {
                CustomAlert.showAlert(withTitle: "Alert", message: err.localizedDescription, viewController: self)
                self.footerView?.setMessage(withText: "Something is wrong 😢.\n\n Please try again.", visibleWaitIndicator:  false)
            } else {
                //show wait indicator
                self.footerView?.resetMessage(visibleWaitIndicator: false)
            }
            self.collectionView.reloadCollectionView()
        }
    }

    
}


// MARK: Extensions

extension ShopController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    // MARK: Collectionview Header and Footer Methods

    // footer size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if products.count > 0 {
            return CGSize(width: collectionView.frame.width, height: 0)
        } else {
            // if no data to display, display full screen footer to show either activity indicator or message for user
            return CGSize(width: collectionView.frame.width, height: 400)
        }
    }

    // header/footer cell
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath) as! CustomFooter
            
            self.footerView = footer
            
            return footer
//        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ShopCell else {
            fatalError("ShopCell not found")
        }

        cell.product = products[indexPath.row]
        cell.isFirstCell = indexPath.row == 0
        cell.delegate = self
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells {
            let indexPath = collectionView.indexPath(for: cell)
            currentProductIndex = indexPath?.row
        }
    }
}


// MARK: Extensions

extension ShopController: ShopCellDelegate {
    
    func didTapOnProductImage() {
        showProductDetails()
    }
    
    func didTapOnProductTitle() {
        showProductDetails()
    }
    
    func didTapOnRatings() {
        // TODO: show ratings page
    }
    
    
    func didTapOnReviews() {
        // TODO: show rewiews page
    }
    
    func didTapOnSave() {
        // TODO: add product to favorite
    }
    
    func didTapOnSend() {
        
    }
    
}
