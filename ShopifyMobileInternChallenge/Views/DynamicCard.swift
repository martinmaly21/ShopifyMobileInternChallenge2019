//
//  CollectionDetailCard.swift
//  ShopifyMobileInternChallenge
//
//  Created by Martin Maly on 2019-01-20.
//  Copyright © 2019 Martin Maly. All rights reserved.
//

import UIKit

class DynamicCard: UICollectionViewCell {
    
    let cardImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let cardTitle: UILabel = {
        let l = UILabel()
        let fontDescriptor = UIFontDescriptor(name: "HelveticaNeue-Bold", size: 0)
        l.font = UIFont(descriptor: fontDescriptor, size: 40)
        l.adjustsFontSizeToFitWidth = true
        l.textColor = UIColor.rgb(red: 38, green: 44, blue: 82)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let cardDescription: UILabel = {
        let l = UILabel()
        let fontDescriptor = UIFontDescriptor(name: "HelveticaNeue-Medium", size: 0)
        l.font = UIFont(descriptor: fontDescriptor, size: 18)
        l.textColor = UIColor.rgb(red: 38, green: 44, blue: 82)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCardView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCardView() {
        //customize view itself
        backgroundColor = UIColor.white
        layer.cornerRadius = 10
        
        //add image
        addSubview(cardImageView)
        
        //add constraints to image
        cardImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cardImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        cardImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        cardImageView.contentMode = .scaleAspectFit
        
        //add card title
        addSubview(cardTitle)
        
        //add constraints to title
        cardTitle.widthAnchor.constraint(equalToConstant: frame.width - 20).isActive = true
        cardTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cardTitle.centerYAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        cardTitle.textAlignment = .center
        
        //add description title
        addSubview(cardDescription)
        
        //add constraints to description
        cardDescription.widthAnchor.constraint(equalToConstant: frame.width / 1.1).isActive = true
        cardDescription.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cardDescription.centerYAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        cardDescription.numberOfLines = 100
        cardDescription.textAlignment = .center
        
    }
}
