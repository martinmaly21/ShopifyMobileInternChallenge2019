//
//  Collect.swift
//  ShopifyMobileInternChallenge
//
//  Created by Martin Maly on 2019-01-20.
//  Copyright © 2019 Martin Maly. All rights reserved.
//

import UIKit

struct CollectArray: Decodable {
    var collects: [Collect]
}

struct Collect: Decodable {
    var product_id: Int?
}



