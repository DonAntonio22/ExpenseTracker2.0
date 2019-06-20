//
//  UnlockViewController.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 17.06.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//

import UIKit
import LocalAuthentication
class UnlockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let context:LAContext = LAContext()
        var authError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To access your Incomes and Expenses use TouchID/FaceID") { complete, error in
                DispatchQueue.main.async {
                    if complete{
                        let overviewVC : OverviewViewController = OverviewViewController(nibName: "OverviewViewController", bundle: nil)
                        
                        self.present(overviewVC, animated: true, completion: nil)
                    }else {
                        print("eroor")
                    }
                }
            }
        }
    }
}


