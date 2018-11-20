//
//  Products.swift
//  Hepsiburada
//
//  Created by eyupcimen on 21.09.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import Foundation
import ObjectMapper

class Products : Mappable {

    var urls        : [String]?
    var title       : String?
    var opp_day     : Bool?
    var ratingCount : String?
    var reviewCount : String?


    required init?(map: Map){
    }

    func mapping(map: Map) {
        urls        <- map["imageUrls"]
        title       <- map["title"]
        opp_day     <- map["opp_day"]
        ratingCount <- map["ratingCount"]
        reviewCount <- map["reviewCount"]


    }
}

