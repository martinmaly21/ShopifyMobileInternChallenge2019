//
//  CollectionDetailCell.swift
//  ShopifyMobileInternChallenge
//
//  Created by Martin Maly on 2019-01-20.
//  Copyright © 2019 Martin Maly. All rights reserved.
//

import UIKit

class CollectionDetailCell: UICollectionViewCell {
    
    var product: Product? {
        didSet {
            productTitle.text = product?.title
            productVendor.text = product?.vendor
            var tempTotal = 0
            for product in (product?.variants)! {
                tempTotal += product.inventory_quantity!
            }
           productInventory.text = "\(tempTotal) items left in stock!"
           setUpImage()
        }
        
    }
    //TODO: render out image
    
    let productTitle: UILabel = {
        let pt = UILabel()
        let fontDescriptor = UIFontDescriptor(name: "HelveticaNeue-Bold", size: 0)
        pt.font = UIFont(descriptor: fontDescriptor, size: 20)
        pt.textColor = UIColor.rgb(red: 38, green: 44, blue: 82)
        pt.numberOfLines = 10
        pt.translatesAutoresizingMaskIntoConstraints = false
        return pt
    }()
    
    let productInventory: UILabel = {
        let pi = UILabel()
        let fontDescriptor = UIFontDescriptor(name: "HelveticaNeue-Light", size: 0)
        pi.font = UIFont(descriptor: fontDescriptor, size: 13)
        pi.textColor = UIColor.rgb(red: 149, green: 191, blue: 72)
        pi.numberOfLines = 10
        pi.translatesAutoresizingMaskIntoConstraints = false
        return pi
    }()
    
    let productVendor: UILabel = {
        let pv = UILabel()
        let fontDescriptor = UIFontDescriptor(name: "HelveticaNeue-Medium", size: 0)
        pv.font = UIFont(descriptor: fontDescriptor, size: 15)
        pv.textColor = UIColor.rgb(red: 38, green: 44, blue: 82)
        pv.numberOfLines = 10
        pv.adjustsFontSizeToFitWidth = true
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    let productImage: UIImageView = {
        let pi = UIImageView()
        pi.translatesAutoresizingMaskIntoConstraints = false
        return pi
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpCell() {
        layer.cornerRadius = 10
        backgroundColor = UIColor.white
        
        //add image view
        addSubview(productImage)
        
        //add constraints for image
        productImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        productImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        productImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: frame.width).isActive = true
        
        //add title
        addSubview(productTitle)
        
        //add constraints for title
        productTitle.topAnchor.constraint(equalTo: productImage.bottomAnchor).isActive = true
        productTitle.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        productTitle.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        productTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        productTitle.contentMode = .center
        productTitle.textAlignment = .center
        
        //add product vendor
        addSubview(productVendor)
        
        //add constraints for vendor
        productVendor.topAnchor.constraint(equalTo: productTitle.bottomAnchor).isActive = true
        productVendor.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        productVendor.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        productVendor.heightAnchor.constraint(equalToConstant: 30).isActive = true
        productVendor.contentMode = .center
        productVendor.textAlignment = .center
        
        //add inventory
        addSubview(productInventory)
        
        //add constraints for inventory
        productInventory.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        productInventory.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        productInventory.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        productInventory.topAnchor.constraint(equalTo: productVendor.bottomAnchor).isActive = true
        productInventory.contentMode = .center
        productInventory.textAlignment = .center
        
        
    }
    
    private func setUpImage() {
        if let image = product?.image?.src {
            guard let url = URL(string: image) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    //alert user
                    print(error!)
                } else {
                    
                    DispatchQueue.main.async {
                        self.productImage.image = UIImage(data: data!)
                    }
                }
            }.resume()
            
        }
    }
    
}
