//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by KOFI on 5/19/20.
//  Copyright © 2020 fiifi_gh. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impletement")
    }
    
    
    private func configure(){
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String){
        
        let cacheKey = NSString(string: urlString)
        if let cacheImage = cache.object(forKey: cacheKey){
            image =  cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else {return}
            if error != nil {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{return}
            guard let data = data else {return}
            
            guard let image = UIImage(data: data) else {return}
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
            
        }
        
        task.resume()
    }

}
