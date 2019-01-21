//
//  File.swift
//  ShopifyMobileInternChallenge
//
//  Created by Martin Maly on 2019-01-20.
//  Copyright © 2019 Martin Maly. All rights reserved.
//

import UIKit

//TODO: explain why this was necessary https://stackoverflow.com/questions/28517866/how-to-set-the-alpha-of-an-uiimage-in-swift-programmatically 
extension UIImage {
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
