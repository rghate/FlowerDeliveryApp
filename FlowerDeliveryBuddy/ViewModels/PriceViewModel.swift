//
//  PriceViewModel.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 25/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

struct PriceViewModel: Decodable {
    let pricePenniesDiscounted: Int
    let pricePennies: Int
    let numberOfDeliveries: Int?
    let duration: Int
    let frequency: Int
    let type: String
    
    init(price: Price) {
        self.pricePenniesDiscounted = price.pricePenniesDiscounted
        self.pricePennies = price.pricePennies
        self.numberOfDeliveries = price.numberOfDeliveries
        self.duration = price.duration
        self.frequency = price.frequency
        self.type = price.type
    }
}
