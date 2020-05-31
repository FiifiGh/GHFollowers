//
//  GFTextField.swift
//  GHFollowers
//
//  Created by KOFI on 5/16/20.
//  Copyright © 2020 fiifi_gh. All rights reserved.
//

import UIKit

class GFTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.systemGray.cgColor
        layer.cornerRadius  = 10
        
        textColor       = .label
        tintColor       = .label
        textAlignment   = .center
        font            = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        
        minimumFontSize         = 12
        backgroundColor         = .tertiarySystemBackground
        autocorrectionType      = .no
        returnKeyType           = .go
        placeholder             = "Enter a username"
    }

}
