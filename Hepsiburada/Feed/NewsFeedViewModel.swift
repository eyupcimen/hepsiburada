//
//  NewsFeedViewModel.swift
//  Hepsiburada
//
//  Created by eyup cimen on 20.11.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import Foundation
import SVProgressHUD


class NewsFeedViewModel {
    
    var products = [Products]()
    var carouselImages = [String]()
    var bannerUrl : String?
    
    func getProducts (success:@escaping (_ products :[Products])->(),fail:@escaping (_ error:String)->() ) {
        
        WebService.getProducts(url:Const.getProductsUrl , success: { (response) in
            self.products = response.productArr!
            success(response.productArr!)
        }) {
            fail("Fail")
        }
    }
    
    func getCarouselImagesUrl ( success:@escaping (_ url : [String] )->(),fail:@escaping (_ error:String)->() )  {
        WebService.getCarouselImages(url:Const.getCarouselImageUrl , success: { (response) in
            success(response.carouselImages!)
        }) {
            fail("Fail")
        }
    }
    
    func getBannerUrl ( success:@escaping (_ bannerUrl : String )->(),fail:@escaping (_ error:String)->()  )  {
        WebService.getBannerInfo(url:Const.getBannerUrl , success: { (response) in
            success(response.bannerImageUrl!)
        }) {
            fail("Fail")
        }
    }
}

