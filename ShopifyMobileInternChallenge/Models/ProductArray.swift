//
//  Products.swift
//  ShopifyMobileInternChallenge
//
//  Created by Martin Maly on 2019-01-19.
//  Copyright © 2019 Martin Maly. All rights reserved.
//

import UIKit

struct ProductArray: Decodable {
    var products: [Product]?
}

struct Product: Decodable {
    var title: String?
    var vendor: String?
    var variants: [Variants]?
    var image: ProductImage?
}

struct Variants: Decodable {
    var inventory_quantity: Int?
}

struct ProductImage: Decodable {
    var src: String?
}
