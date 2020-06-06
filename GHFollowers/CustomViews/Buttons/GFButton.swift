//
//  GFButton.swift
//  GHFollowers
//
//  Created by KOFI on 5/16/20.
//  Copyright © 2020 fiifi_gh. All rights reserved.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(title:String,backgroundColor:UIColor){
        super.init(frame:.zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal )
        configure()
    }
    
    private func configure(){
        layer.cornerRadius        = 10
        titleLabel?.textAlignment = .center
        titleLabel?.font          = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func set(backgroundColor: UIColor, title: String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
}
