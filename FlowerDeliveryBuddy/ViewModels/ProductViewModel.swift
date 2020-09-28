//
//  ProductViewModel.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 25/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation
import UIKit

struct ProductViewModel {
    
    let id: String
    let attributes: AttributesViewModel
        
    var preOrderMessage: NSMutableAttributedString? {
        // messageText will be popullated only when preorder is true
        guard attributes.isPreOrder == true else {
            return nil
        }
                
        if let calendarComonent = attributes.deliverableFrom.getCalenderComponent() {
            let italicFont = UIFont.italicSystemFont(ofSize: 18)
            let boldFont = UIFont.boldSystemFont(ofSize: 18)
            
            let text1 = NSMutableAttributedString(string: "Order now for delivery from ", attributes: [NSAttributedString.Key.font : italicFont])
            let text2 = NSAttributedString(string: " \(calendarComonent.day) \(calendarComonent.monthName)", attributes: [NSAttributedString.Key.font: boldFont])
            
            let combine = NSMutableAttributedString()
            combine.append(text1)
            combine.append(text2)
            
            return combine
        }
        return nil
    }
    
    var mediaUrls: [URL] {
        return attributes.media.compactMap {
            URL(string: $0.url)
        }
    }
    
    
    init?(product: Product) {
        guard let attributes = AttributesViewModel(attributes: product.attributes) else {
            print("Error: failed to create product attribute object for product id \(product.id)")
            return nil
        }
        
        self.id = product.id
        self.attributes = attributes
    }
    
    static func fetchProducts(forCountryId id: String, locale: String = "en", completion: @escaping (Result<[ProductViewModel], CustomError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let queryItems = [
                URLQueryItem(name: "locale", value: locale),
                URLQueryItem(name: "shipping_country_id", value: id),
                URLQueryItem(name: "first_item_in_purchase", value: "true")
            ]
            
            let config = NetworkConfiguration(scheme: NetworkConstants.SCHEME, host: NetworkConstants.BASE_URL, path: NetworkConstants.PRODUCTS_PATH, queryItems: queryItems)
            print(config.urlComponent ?? "")
            
            loadFromNetwork(configuration: config, completion: { result in
                switch result {
                case .failure(let err):
                    print(err)
                    completion(.failure(err))
                case .success(let data):
                    handleResult(data: data, completion: completion)
                    print("Success")
                }
            })
        }
    }
    
    static private func loadFromNetwork(configuration: NetworkConfiguration, completion: @escaping (Result<Data, CustomError>) -> Void) {
        //https://api.bloomandwild.com/v2/availability/products?locale=en&shipping_country_id=1&first_item_in_purchase=true
        let apiServiceMgr = APIService()
        
        let err = apiServiceMgr.fetch(configuration: configuration) { result in
            completion(result)
            
        }
        if let err = err {
            completion(.failure(err))
        }
        
    }
    
    static private func handleResult(data: Data, completion: @escaping (Result<[ProductViewModel], CustomError>) -> Void) {
        
        var productsVM = [ProductViewModel]()
        
        do {
            let products = try DataParser.parseProducts(data: data)
            
            productsVM = products.compactMap { product in
                ProductViewModel(product: product)
            }
            
            completion(.success(productsVM))
        } catch let err {
            print(err)
            completion(.failure(CustomError(description: "Data parsing error")))
        }
    }
 
    
    
    // TODO:  Methods for filterig products based on different values (letterbox, hand-tied, occassion, subscriptions, sorting) can be done here
}
