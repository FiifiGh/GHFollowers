//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by KOFI on 6/6/20.
//  Copyright © 2020 fiifi_gh. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController {

    let stackview       = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton    = GFButton()
    
    var user: User!
  
    init(user: User) {
      super.init(nibName: nil, bundle: nil)
      self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundView()
        layoutUI()
        configureStackView()

    }
    
    private func configureBackgroundView(){
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 18
        
    }
    
    private func configureStackView(){
        stackview.axis = .horizontal
        stackview.distribution = .equalSpacing
        
        stackview.addArrangedSubview(itemInfoViewOne)
        stackview.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func layoutUI(){
        view.addSubview(stackview)
        view.addSubview(actionButton)
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackview.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),

            
        ])
    }
    


}
