//
//  WebService.swift
//  Hepsiburada
//
//  Created by eyupcimen on 21.09.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper



class WebService {

    var baseError: Error?
    private class func request<T: Mappable>(uri: String, method: HTTPMethod, success: @escaping (T) -> Void, failure: @escaping () -> () ) {

        var encoding: ParameterEncoding!
        switch method {
        case .get:
            encoding = URLEncoding.default
        case .put:
            encoding = URLEncoding.default
        case .delete:
            encoding = URLEncoding.default
        default:
            encoding = JSONEncoding.default
            break
        }

        Alamofire.request(uri , method: method ,  encoding: encoding  ).validate().responseJSON { response in

            if response.result.isSuccess {
                var dataString:String?
                if let responseData = response.data{
                    dataString = String.init(data: responseData, encoding: String.Encoding.utf8)
                }
                print("[Response]: \(uri)\n \(dataString ?? response.result.value!)")
                if let object = Mapper<T>().map(JSON: response.result.value as! [String: Any]) {
                    success(object)
                    return
                }
            }
            if response.result.isFailure {
                failure()
            }
        }
    }

    class func getProducts( url : String? , success: @escaping ( ProductResult ) -> Void, failure: @escaping () -> () ) {

        WebService.request(uri: url! , method: .get , success: { (response : ProductResult ) in
            if ( response.productArr != nil ) {
                success(response)
            } else {
                failure()
            }
        }) {
            failure()
        }
    }

    class func getCarouselImages( url : String? , success: @escaping ( CarouselResult ) -> Void, failure: @escaping () -> ()) {

        WebService.request(uri: url! , method: .get , success: { (response : CarouselResult ) in
            if ( response.carouselImages != nil ) {
                success(response)
            } else {
                failure()
            }
        }) {
            failure()
        }
    }

    class func getBannerInfo( url : String? ,  success: @escaping ( BannerResult  ) -> Void, failure: @escaping () -> () ) {
        
        WebService.request(uri: url! , method: .get , success: { (response : BannerResult  ) in
            if ( response.bannerImageUrl != nil ) {
                success(response)
            } else {
                failure()
            }
        }) {
            failure()
        }
    }
    
    public func getProducts (success:@escaping (_ products :[Products])->(),fail:@escaping (_ error:String)->() ) {
        
        WebService.getProducts(url:Const.getProductsUrl , success: { (response) in 
            success(response.productArr!)
        }) {
            fail("Fail")
        }
    }
    
    public func getCarouselImagesUrl ( success:@escaping (_ url : [String] )->(),fail:@escaping (_ error:String)->() )  {
        WebService.getCarouselImages(url:Const.getCarouselImageUrl , success: { (response) in
            success(response.carouselImages!)
        }) {
            fail("Fail")
        }
    }
    
    public func getBannerUrl ( success:@escaping (_ bannerUrl : String )->(),fail:@escaping (_ error:String)->()  )  {
        WebService.getBannerInfo(url:Const.getBannerUrl , success: { (response) in
            success(response.bannerImageUrl!)
        }) {
            fail("Fail")
        }
    }
}




