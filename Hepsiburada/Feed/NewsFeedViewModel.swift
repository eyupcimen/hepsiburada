//
//  NewsFeedViewModel.swift
//  Hepsiburada
//
//  Created by eyup cimen on 20.11.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import Foundation
import SVProgressHUD


final class NewsFeedViewModel : NewsFeedViewModelProtocol {
    
    weak var delegate: NewsFeedViewModelDelegate?
    
    var products : [Products] = []
    var carouselImages : [String] = []
    var bannerUrl : String?
    
    func load() {
        WebService().getProducts(success: { (productLists) in
            self.products = productLists
            self.applyOutput(output: .showProducts(productLists))
        }) { (err) in
            print(err)
        }
        
        WebService().getCarouselImagesUrl(success: { (imageUrls) in
            self.carouselImages  = imageUrls
            self.applyOutput(output: .iCarouselImages(imageUrls))
        }) { (err) in
            print(err)
        }
        
        WebService().getBannerUrl(success: { (bannerUrl) in
            self.bannerUrl = bannerUrl
            self.applyOutput(output: .getBannerUrl(bannerUrl))
        }) { (err) in
            print(err)
        }
    }
    
    func applyOutput(output : NewsFeedViewModelOutput)  {
        delegate?.handleViewModel(output)
    }
}

