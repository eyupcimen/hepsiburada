//
//  File.swift
//  Hepsiburada
//
//  Created by eyupcimen on 23.09.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import Foundation

extension UIImageView {

    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}

