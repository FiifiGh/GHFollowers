//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by KOFI on 5/17/20.
//  Copyright © 2020 fiifi_gh. All rights reserved.
//

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontsize: CGFloat){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = .systemFont(ofSize: fontsize, weight: .bold)
        configure()
    }
    
    private func configure(){
        textColor                 = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.9
        lineBreakMode             = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    

}
