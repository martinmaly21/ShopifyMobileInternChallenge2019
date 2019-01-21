//
//  Collections.swift
//  ShopifyMobileInternChallenge
//
//  Created by Martin Maly on 2019-01-19.
//  Copyright © 2019 Martin Maly. All rights reserved.
//

import UIKit

struct CollectionImage: Decodable {
    var src: String
}

struct Collection: Decodable {
    var id: Int?
    var title: String?
    var body_html: String?
    var productIDs : [Int]?
    var image: CollectionImage?
}

struct CollectionArray: Decodable {
    var custom_collections: [Collection]
}


