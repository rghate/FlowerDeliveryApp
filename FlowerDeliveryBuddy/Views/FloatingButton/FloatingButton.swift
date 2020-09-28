//
//  FloatingButton.swift
//  FlowerDeliveryBuddy
//
//  Created by Rupali on 17/09/2020.
//  Copyright © 2020 rghate. All rights reserved.
//


import UIKit

protocol FloatingButtonDelegate: class {
    func handleFloatingButton()
}

final class FloatingButton: UIButton {

    weak var delegate: FloatingButtonDelegate?
    
    var showShadow: Bool = true {
        didSet {
            if !showShadow {
                self.layer.shadowColor = UIColor.clear.cgColor
                layer.shadowOpacity = 0.0
            }
        }
    }
    
    private var buttonRadius: CGFloat = 0
    
    init(frame: CGRect, withRadius radius: CGFloat) {
        super.init(frame: frame)
        
        self.buttonRadius = radius
        
        setupView()
    }
    
    private func setupView() {
        isUserInteractionEnabled = true

        //default properties -- can be overriden in parent class
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Color.PRIMARY_ACCENT_COLOR
        layer.cornerRadius = buttonRadius
        layer.masksToBounds = false
        layer.shadowColor = UIColor(white: 0, alpha: 0.7).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 1.0
        tintColor = .white
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)

        self.heightAnchor.constraint(equalToConstant: buttonRadius * 2).isActive = true
        self.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
        
        addTarget(self, action: #selector(handleButtonClick), for: .touchUpInside)
    }
    
    @objc private func handleButtonClick() {
        delegate?.handleFloatingButton()
    }
    
    //MARK: Public methods

    func disable() {
        tintColor = .lightGray
        isUserInteractionEnabled = false
    }

    func enable() {
        tintColor = .white
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
    
}
