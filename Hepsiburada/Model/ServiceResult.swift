//
//  ServiceResult.swift
//  Hepsiburada
//
//  Created by eyupcimen on 21.09.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


class ServiceResult : NSObject, Mappable{

    var serviceResult       : ProductResult?

    required init?(map: Map) { }
    public func mapping(map: Map) {
        serviceResult       <- map
    }
}

