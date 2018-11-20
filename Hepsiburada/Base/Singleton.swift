//
//  Singleton.swift
//  Hepsiburada
//
//  Created by eyupcimen on 21.09.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import Foundation
import UIKit


class Singleton : NSObject {

    static let shared : Singleton = {
        let instance  = Singleton()
        return instance
    }()

    private override init() {
    }

    var userEmail : String?
    var userPassword : String?
    var navigationColor : UIColor?
}



