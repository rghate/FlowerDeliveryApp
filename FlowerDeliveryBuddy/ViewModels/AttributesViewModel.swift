//
//  Attributes.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 25/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation
import UIKit

struct AttributesViewModel {
    let addonSpace: Int?
    let appearingFrom: Date
    let appearingTo: Date
    //        let associatedSkus: AssociatedSku   //??
    let bundleOnly: Bool
    let collectionId: Int
    let collectionName: String
    let currency: String
    let deliverableFrom: Date
    let deliverableTo: Date
    let description: String
    let discountInfo: String?
    let eighteenPlus: Bool
    let emailDescription: String
    let expressSkuId: Int?
    let expressStockDates: [String]
    let inStockOnDates: [String]
    let isExpress: Bool
    let isPreOrder: Bool
    let lilyFree: Bool
    let longDescription: String
    let media: [MediaViewModel]
    let name: String
    let priceData: [PriceDataViewModel] // TODO: convert to amount from pennies based on currency
    let prices: [PriceViewModel]    // TODO: convert to amount from pennies based on currency
    let ratingAverage: Double?
    let ratingCount: Int
    let singleOnly: Bool
    let skuAttributes: [SkuAttributesViewModel]
    let slug: String
    let subscriptionOnly: Bool
    let tags: [String]
    
    
    init?(attributes: Attributes) {
        guard let deliverableFrom = DateFormatter.dateFormatterWithNoTime.date(from: attributes.deliverableFrom),
            let deliverableTo  = DateFormatter.dateFormatterWithNoTime.date(from: attributes.deliverableTo),
            let appearingFrom =  DateFormatter.dateFormatterWithLongTime.date(from: attributes.appearingFrom),
            let appearingTo =  DateFormatter.dateFormatterWithLongTime.date(from: attributes.appearingTo) else {
                print("One of the date from product name \(attributes.name) is invalid")
                return nil
        }
        
        self.addonSpace = attributes.addonSpace
        self.appearingFrom = appearingFrom
        self.appearingTo = appearingTo
        
        //            self.associatedSkus = AssociatedSku()
        
        self.bundleOnly = attributes.bundleOnly
        self.collectionId = attributes.collectionId
        self.collectionName = attributes.collectionName
        self.currency = attributes.currency
//        DateFormatter.dateFormatterWithLongTime.date(from: endDateStr),
        self.deliverableFrom = deliverableFrom
        self.deliverableTo = deliverableTo
        self.description = attributes.description
        self.discountInfo = attributes.discountInfo
        self.eighteenPlus = attributes.eighteenPlus
        self.emailDescription = attributes.emailDescription
        self.expressSkuId = attributes.expressSkuId
        self.expressStockDates = attributes.expressStockDates
        self.inStockOnDates = attributes.inStockOnDates
        self.isExpress = attributes.isExpress
        self.isPreOrder = attributes.isPreOrder
        self.lilyFree = attributes.lilyFree
        self.longDescription = attributes.longDescription
        
        self.media = attributes.media.map {
            MediaViewModel(media: $0)
        }
        
        self.name = attributes.name
        
        self.priceData = attributes.priceData.map { priceData in
            PriceDataViewModel(priceData: priceData)
        }
        
        self.prices = attributes.prices.map { price in
            PriceViewModel(price: price)
        }
        
        self.ratingAverage = attributes.ratingAverage
        self.ratingCount = attributes.ratingCount
        self.singleOnly = attributes.singleOnly
        
        self.skuAttributes = attributes.skuAttributes.map { skuAttribute in
            SkuAttributesViewModel(skuAttribute: skuAttribute)
        }
        
        self.slug = attributes.slug
        self.subscriptionOnly = attributes.subscriptionOnly
        self.tags = attributes.tags
        
    }
}

