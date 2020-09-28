//
//  SkuAttributesViewModel.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 25/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

struct SkuAttributesViewModel {
    let key: String
    let values: [String]
    
    init(skuAttribute: SkuAttribute) {
        self.key = skuAttribute.key
        self.values = skuAttribute.values
    }
}
