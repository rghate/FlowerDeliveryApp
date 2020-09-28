//
//  PBButton.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 17/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

class FlatButton: UIButton {
    
    struct FlatButtonSettings {
        var backgroundColor = Color.BUTTON_BACKGROUND_COLOR
        var titleColor = Color.BUTTON_TEXT_COLOR
        var titleFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        var borderColor = Color.BUTTON_BACKGROUND_COLOR
        var cornerRadius: CGFloat = 0
        var borderWidth: CGFloat = 1
    }

    private lazy var settings = FlatButtonSettings()
    
    init(withTitle title: String) {
        super.init(frame: .zero)
        
        self.setTitle(title.uppercased(), for: .normal)
        setupView(withTitle: title)

    }
    
    init(withTitle title: String, andSetting settings: FlatButtonSettings ) {
        super.init(frame: .zero)
        
        self.settings = settings
        self.setTitle(title, for: .normal)

        setupView(withTitle: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView(withTitle title: String) {
        self.backgroundColor = settings.backgroundColor
        self.setTitleColor(settings.titleColor, for: .normal)
        
        self.titleLabel?.font = settings.titleFont

        self.layer.borderColor = settings.borderColor.cgColor
        self.layer.borderWidth = settings.borderWidth
        self.layer.cornerRadius = settings.cornerRadius
        self.clipsToBounds = true
    }
}
