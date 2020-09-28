//
//  CustomNavigationController.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 17/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        customizeNavigationBar()
    }
    
    func customizeNavigationBar(backgroundColor: UIColor = Color.NAVIGATIONBAR_BACKGROUND_COLOR,
                                    tintColor: UIColor = Color.NAVIGATIONBAR_TINT_COLOR,
                                    titleColor: UIColor = Color.NAVIGATIONBAR_TITLE_COLOR) {
        
        // make navigation bar transparent
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        
        // set title and bar item color properties
        self.navigationController?.navigationBar.barTintColor = backgroundColor
        self.navigationController?.navigationBar.tintColor  = tintColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : titleColor]
    }

}
