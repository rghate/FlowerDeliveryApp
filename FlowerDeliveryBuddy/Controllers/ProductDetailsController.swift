//
//  ProductDetailsController.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 17/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class ProductDetailsController: BaseControlller {
    
    // MARK: Public properties
    var productTitle: String? {
        didSet {
            if let title = productTitle {
                titleLabel.text = title
            }
        }
    }
    
    
    // MARK: Private properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        return label
    }()
    
    
    // MARK: Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        titleLabel.centerInSuperview()
    }
}



