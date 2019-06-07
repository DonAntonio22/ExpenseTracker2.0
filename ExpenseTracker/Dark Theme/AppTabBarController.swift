//
//  AppTabBarController.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 01.06.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//

import UIKit

class AppTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTheming()
    }
}

extension AppTabBarController: Themed {
    func applyTheme(_ theme: AppTheme) {
        tabBar.barTintColor = theme.barBackgroundColor
        tabBar.tintColor = theme.barForegroundColor
    }
}
