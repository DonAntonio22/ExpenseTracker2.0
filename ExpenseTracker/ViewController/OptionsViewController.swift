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

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        //backButton.contentEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 70)
    }
    
    @IBAction func darkModeSwitchOn(_ sender: Any) {
        if darkModeSwitch.isOn == true {
            darkModeLabel.textColor = UIColor.white
            optionsBackgroundView.backgroundColor = UIColor.darkGray
        } else {
            darkModeLabel.textColor = UIColor.black
            optionsBackgroundView.backgroundColor = UIColor.white
        }
        //ThemeProvider.nextTheme()
    }
}
