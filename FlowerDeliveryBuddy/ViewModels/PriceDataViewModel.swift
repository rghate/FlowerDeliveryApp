//
//  PriceDataViewModel.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 25/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

struct PriceDataViewModel: Decodable {
    let pricePenniesDiscounted: Int
    let pricePennies: Int
    let quantity: Int?
    
    init(priceData: PriceData) {
        self.pricePenniesDiscounted = priceData.pricePenniesDiscounted
        self.pricePennies = priceData.pricePennies
        self.quantity = priceData.quantity
    }
}
