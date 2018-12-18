//
//  NewsFeedContracts.swift
//  Hepsiburada
//
//  Created by eyup cimen on 18.12.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import Foundation

protocol NewsFeedViewModelProtocol:class {
    var  delegate : NewsFeedViewModelDelegate? {get set}
    func load()
}

enum NewsFeedViewModelOutput {
    case loading(Bool)
    case showProducts([Products])
    case iCarouselImages([String])
    case getBannerUrl(String)
}

protocol NewsFeedViewModelDelegate:class {
    func handleViewModel(_ output:NewsFeedViewModelOutput)
}
