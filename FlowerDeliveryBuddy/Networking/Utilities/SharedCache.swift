//
//  SharedCache.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 22/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class SharedCache {
    static let shared = SharedCache()
    //MARK: Public variables


    //MARK: Initializers

    private init() {
    }
    
    //MARK: Public Methods
    /**
        Function to clear image  as well as URLcache
     */
    func clearAllCache() {
        // clear URL cache
        URLCache.shared.removeAllCachedResponses()
    }
}
