//
//  Const.swift
//  Hepsiburada
//
//  Created by eyupcimen on 21.09.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import Foundation
import UIKit


struct Const  {

    static let getProductsUrl  = "https://us-central1-hepsiburada-62802.cloudfunctions.net/getProducts"
    static let getCarouselImageUrl  = "https://us-central1-hepsiburada-62802.cloudfunctions.net/getiCarouselImages"
    static let getBannerUrl = "https://us-central1-hepsiburada-62802.cloudfunctions.net/getBanner"


    static let window   = UIApplication.shared.keyWindow
    static let APP_NAME             = "Hepsiburada"

    static let viewBackgroundColor  : UIColor =  getColor(r: 233, g: 233, b: 233 , a: 1)
    static let hepsiBuradaOrange  : UIColor = getColor(r: 239, g: 127, b: 26 , a: 1)
    static let cellTextColor  : UIColor       = getColor(r: 122, g: 122, b: 122, a: 1)

    static let avenirNextLTProRegular                   = UIFont(name: "AvenirNextLTPro-Regular", size: 13)
    static let avenirNextLTPro                          = UIFont(name: "AvenirNextLTPro-Demi", size: 13)
}

func getColor (r: CGFloat , g: CGFloat , b: CGFloat , a: CGFloat) -> UIColor {
    return UIColor(red: r/255.0 , green: g/255.0 , blue: b/255.0, alpha: a/1.0)
}



