//
//  DataParser.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 22/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

final class DataParser {
    static func parseProducts(data: Data) throws -> [Product] {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
            let productsData = try decoder.decode(ResponseData.self, from: data)
            
            return productsData.data
        }
    }
}
