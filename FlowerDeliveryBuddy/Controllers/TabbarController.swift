//
//  TabbarController.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 17/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: Private properties

    
    // MARK: Initializers
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        setupTabBar()
        customizeNavigationBar()
    }
    
    // MARK: Handlers
    

    // MARK: Private methods
    
    private func setupTabBar() {
        tabBar.barTintColor = Color.TABBAR_BACKGROUND_COLOR
        tabBar.tintColor = Color.TABBAR_ITEM_TINT_COLOR
        tabBar.unselectedItemTintColor = Color.TABBAR_ITEM_TINT_COLOR
        
        // remove tabbar top border
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.layer.borderWidth = 0
        tabBar.clipsToBounds = true
    }
    
    func customizeNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
}


// MARK: FloatingMenuDelegate
