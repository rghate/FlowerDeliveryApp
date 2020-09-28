//
//  UIImageView.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 22/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    /**
     SDWebImage method to download and set image.
     
     @Param - url of the image to be downloaded.
     */
    func loadImage(with url: URL) {
        sd_imageIndicator = SDWebImageActivityIndicator.gray
        sd_setImage(with: url) { [weak self](_, err, _, _) in
            if err != nil {
                //if failed to download, set degault background color to show as image placeholder
//                self?.backgroundColor = .placeholderBackgroundColor
                print("Failed for: ", url)
            } else {
                //if image set successfully, clear background color
                self?.backgroundColor = .clear
            }
        }
    }
}
