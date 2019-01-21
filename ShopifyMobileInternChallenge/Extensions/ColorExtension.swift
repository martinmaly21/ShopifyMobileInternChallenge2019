//
//  ColorExtension.swift
//  ShopifyMobileInternChallenge
//
//  Created by Martin Maly on 2019-01-19.
//  Copyright © 2019 Martin Maly. All rights reserved.
//

import UIKit

extension UIColor {

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        let colour = UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
        return colour
    }
    
    
}
