//
//  CollectionCell.swift
//  ShopifyMobileInternChallenge
//
//  Created by Martin Maly on 2019-01-19.
//  Copyright © 2019 Martin Maly. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    var collection: Collection? {
        didSet {
            title.text = collection?.title
            imageView.image = UIImage(named: (collection?.image!.src)!)
            setUpImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let title: UILabel = {
        let t = UILabel()
        t.textColor = UIColor.rgb(red: 38, green: 44, blue: 82)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private func setUpViews() {
        //customize cell itself
        backgroundColor = UIColor.white
        layer.cornerRadius = 10
        
        //add image view 
        addSubview(imageView)
        
        //add constraints for image view
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        
        //add title view
        addSubview(title)
        title.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        title.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        title.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        title.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        title.textAlignment = .center
        title.contentMode = .center
        
        //do setup with text colour and formatting
        let fontDescriptor = UIFontDescriptor(name: "HelveticaNeue-Medium", size: 0)
        title.font = UIFont(descriptor: fontDescriptor, size: 15)
        
    }
    
    private func setUpImage() {
        if let imageURL = collection?.image!.src {
            guard let url = URL(string: imageURL) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    //alert user
                    print(error!)
                    return
                } else {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data!)
                    }
                }
                }.resume()
        }
    }
}

