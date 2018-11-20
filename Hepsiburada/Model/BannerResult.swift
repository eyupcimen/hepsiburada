//
//  BannerResult.swift
//  Hepsiburada
//
//  Created by eyupcimen on 22.09.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import Foundation
import ObjectMapper

class BannerResult : Mappable {

    var bannerUrl           : String?
    var bannerImageUrl      : String?

    required init?(map: Map){ }

    func mapping(map: Map) {
        bannerUrl           <- map["bannerUrl"]
        bannerImageUrl      <- map["bannerImageUrl"]
    }
}

