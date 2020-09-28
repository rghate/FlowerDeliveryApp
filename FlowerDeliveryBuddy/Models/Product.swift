//
//  Product.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 22/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

struct ResponseData: Decodable {
    let data: [Product]
}

struct Product: Decodable {
    let id: String
    let type: String
    let attributes: Attributes
}

struct Attributes: Decodable {
    let addonSpace: Int?
    let appearingFrom: String
    let appearingTo: String
    let associatedSkus: AssociatedSku
    let bundleOnly: Bool
    let collectionId: Int
    let collectionName: String
    let currency: String
    let deliverableFrom: String
    let deliverableTo: String
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
    let media: [Media]
    let name: String
    let priceData: [PriceData]
    let prices: [Price]
    let ratingAverage: Double?
    let ratingCount: Int
    let singleOnly: Bool
    let skuAttributes: [SkuAttribute]
    let slug: String
    let subscriptionOnly: Bool
    let tags: [String]
}

struct AssociatedSku: Decodable {
    
}

struct Media: Decodable {
    let ratioWidth: Double
    let ratioHeight: Double
    let tagsIos: [String]
    let url: String
    let mediaType: String
}

struct PriceData: Decodable {
    let pricePenniesDiscounted: Int
    let pricePennies: Int
    let quantity: Int?
}

struct Price: Decodable {
    let pricePenniesDiscounted: Int
    let pricePennies: Int
    let numberOfDeliveries: Int?
    let duration: Int
    let frequency: Int
    let type: String
}

struct SkuAttribute: Decodable {
    let key: String
    let values: [String]
}
