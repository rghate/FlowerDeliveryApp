//
//  ProductViewModelTests.swift
//  FlowerDeliveryBuddyTests
//
//  Created by Rupali on 28/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

import XCTest

@testable import FlowerDeliveryBuddy

class ProductViewModelTests: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
        
    }
    
    func testProductViewModel() {
        
        let associatedSku = AssociatedSku()
        
        let media = Media(ratioWidth: 1, ratioHeight: 1, tagsIos: [], url: "https://assets-0.bloomandwild.com/letterbox-main/the-harper-now/2d2dded9-a9db-4185-96ff-22a35017780f.jpg", mediaType: "image")
        
        let priceData = PriceData(pricePenniesDiscounted: 3800, pricePennies: 3800, quantity: 1)
        
        let price = Price(pricePenniesDiscounted: 3800, pricePennies: 3800, numberOfDeliveries: 1, duration: 1, frequency: 0, type: "one_off")
        
        let skuAttributes = SkuAttribute(key: "stems", values: ["snapdragons", "alstroemeria", "roses"])

        let attributes = Attributes(addonSpace: 0, appearingFrom: "2018-03-13T00:00:00.000+00:00", appearingTo: "2020-11-07T16:00:00.000+00:00", associatedSkus: associatedSku, bundleOnly: false, collectionId: 14, collectionName: "Letterbox Flowers", currency: "GBP", deliverableFrom: "2018-04-17", deliverableTo: "2020-11-08", description: "This is description", discountInfo: "", eighteenPlus: false, emailDescription: "This is email description", expressSkuId: 0, expressStockDates: [], inStockOnDates: [], isExpress: true, isPreOrder: true, lilyFree: true, longDescription: "This is a long description", media: [media], name: "The Jamila", priceData: [priceData], prices: [price], ratingAverage: 5.0, ratingCount: 101, singleOnly: true, skuAttributes: [skuAttributes], slug: "the-jamila", subscriptionOnly: false, tags: ["birthday", "letterbox-flowers", "letterbox"])
        

        let product = Product(id: "160", type: "products", attributes: attributes)
        
        // product view model
        let productViewMmodel = ProductViewModel(product: product)
        XCTAssertNotNil(productViewMmodel)
        
        XCTAssertEqual(productViewMmodel?.id, "160")        
        
        // attributes view model
        let attributesVM = productViewMmodel!.attributes
        XCTAssertNotNil(attributesVM)
        
        XCTAssertEqual(attributesVM.addonSpace, 0)
        XCTAssertEqual(attributesVM.appearingFrom, DateFormatter.dateFormatterWithLongTime.date(from: attributes.appearingFrom))
        XCTAssertEqual(attributesVM.appearingTo, DateFormatter.dateFormatterWithLongTime.date(from: attributes.appearingTo))
        XCTAssertEqual(attributesVM.bundleOnly, false)
        XCTAssertEqual(attributesVM.collectionId, 14)
        XCTAssertEqual(attributesVM.collectionName, "Letterbox Flowers")
        XCTAssertEqual(attributesVM.currency, "GBP")
        XCTAssertEqual(attributesVM.deliverableFrom, DateFormatter.dateFormatterWithNoTime.date(from: attributes.deliverableFrom))
        XCTAssertEqual(attributesVM.deliverableTo, DateFormatter.dateFormatterWithNoTime.date(from: attributes.deliverableTo))
        XCTAssertEqual(attributesVM.description, "This is description")
        XCTAssertEqual(attributesVM.discountInfo, "")
        XCTAssertEqual(attributesVM.eighteenPlus, false)
        XCTAssertEqual(attributesVM.emailDescription, "This is email description")
        XCTAssertEqual(attributesVM.expressSkuId, 0)
        XCTAssertEqual(attributesVM.expressStockDates, [])
        XCTAssertEqual(attributesVM.inStockOnDates, [])
        XCTAssertEqual(attributesVM.isExpress, true)
        XCTAssertEqual(attributesVM.isPreOrder, true)
        XCTAssertEqual(attributesVM.lilyFree, true)
        XCTAssertEqual(attributesVM.longDescription, "This is a long description")
        XCTAssertEqual(attributesVM.name, "The Jamila")
        XCTAssertEqual(attributesVM.ratingAverage, 5.0)
        XCTAssertEqual(attributesVM.ratingCount, 101)
        XCTAssertEqual(attributesVM.singleOnly, true)
        XCTAssertEqual(attributesVM.slug, "the-jamila")
        XCTAssertEqual(attributesVM.subscriptionOnly, false)
        XCTAssertEqual(attributesVM.tags, ["birthday", "letterbox-flowers", "letterbox"])
        
        // media view model
        XCTAssertNotNil(attributesVM.media)
        let mediaVM = attributesVM.media

        XCTAssertEqual(mediaVM[0].ratioWidth, 1)
        XCTAssertEqual(mediaVM[0].ratioHeight, 1)
        XCTAssertEqual(mediaVM[0].tagsIos, [])
        XCTAssertEqual(mediaVM[0].url, "https://assets-0.bloomandwild.com/letterbox-main/the-harper-now/2d2dded9-a9db-4185-96ff-22a35017780f.jpg")
        XCTAssertEqual(mediaVM[0].mediaType, "image")
        

        // skuAttributes view model
        XCTAssertNotNil(attributesVM.skuAttributes)
        let skuAttributesVM = attributesVM.skuAttributes

        XCTAssertEqual(skuAttributesVM[0].key, "stems")
        XCTAssertEqual(skuAttributesVM[0].values, ["snapdragons", "alstroemeria", "roses"])
        
        
        // priceData view model
        XCTAssertNotNil(attributesVM.priceData)
        let priceDataVM = attributesVM.priceData
        
        XCTAssertEqual(priceDataVM[0].pricePenniesDiscounted, 3800)
        XCTAssertEqual(priceDataVM[0].pricePennies, 3800)
        XCTAssertEqual(priceDataVM[0].quantity, 1)
        
        
        // prices view model
        XCTAssertNotNil(attributesVM.prices)
        let pricesVM = attributesVM.prices

        XCTAssertEqual(pricesVM[0].pricePenniesDiscounted, 3800)
        XCTAssertEqual(pricesVM[0].pricePennies, 3800)
        XCTAssertEqual(pricesVM[0].numberOfDeliveries, 1)
        XCTAssertEqual(pricesVM[0].duration, 1)
        XCTAssertEqual(pricesVM[0].frequency, 0)
        XCTAssertEqual(pricesVM[0].type, "one_off")

    }
    
}
