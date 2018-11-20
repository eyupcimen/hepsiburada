//
//  ProductResult.swift
//  Hepsiburada
//
//  Created by eyupcimen on 21.09.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductResult : Mappable {

    var productArr: [Products]?

    required init?(map: Map){ }

    func mapping(map: Map) {
        productArr  <- map["newsArr"]
    }
}
