//
//  OptionsViewController.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 01.06.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    @IBOutlet weak var optionsBackgroundView: UIView!
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backButtonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = UIColor.black
    }
    

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toggleDarkModeSwitch(_ sender: UISwitch) {
        if darkModeSwitch.isOn == true{
            UITabBar.appearance().tintColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        }else{
            UITabBar.appearance().tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    
}

