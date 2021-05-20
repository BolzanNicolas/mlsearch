//
//  BaseNavigationController.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 19/05/2021.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        additionalSafeAreaInsets.top = 10
        navigationBar.barTintColor = UIColor(named: "AccentColor")!
        navigationBar.tintColor = .white
        
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNeedsStatusBarAppearanceUpdate()
    }
    
}
