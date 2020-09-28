//
//  MediaViewModel.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 25/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import Foundation

struct MediaViewModel {
    let ratioWidth: Double
    let ratioHeight: Double
    let tagsIos: [String]
    let url: String
    let mediaType: String
    
    init(media: Media) {
        self.ratioWidth = media.ratioWidth
        self.ratioHeight = media.ratioHeight
        self.tagsIos = media.tagsIos
        self.url = media.url
        self.mediaType = media.mediaType
    }
}
