//
//  BaseVC.swift
//  Hepsiburada
//
//  Created by eyupcimen on 21.09.2018.
//  Copyright © 2018 eyupcimen. All rights reserved.
//

import UIKit
import Foundation




class BaseVC: UIViewController {


    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppSettings()
    }

    func configureAppSettings ()  {
        self.view.backgroundColor   = UIColor.white
        self.view.tintColor         = UIColor.white
        self.navigationController?.navigationBar.barStyle  = .default
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = Singleton.shared.navigationColor
    }

    override func viewWillAppear(_ animated: Bool) {
    }


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func simpleAlert(message : String ) {
        let cancel  = UIAlertAction(title: "Okay" /*txt_button_ok*/ , style: .default) { (action) in
        }
        let view    = UIAlertController(title: "" , message: message , preferredStyle: .alert)
        view.addAction(cancel)
        self.present(view, animated: true , completion: nil)
    }
}

