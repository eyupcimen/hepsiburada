//
//  CarouselResult.swift
//  Hepsiburada
//
//  Created by eyupcimen on 22.09.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import Foundation
import ObjectMapper

class CarouselResult : Mappable {

    var carouselImages: [String]?

    required init?(map: Map){ }

    func mapping(map: Map) {
        carouselImages  <- map["array"]
    }

}
