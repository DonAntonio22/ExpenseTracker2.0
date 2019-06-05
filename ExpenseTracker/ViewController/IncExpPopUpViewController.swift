//
//  IncExpPopUpViewController.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 16.04.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//

import UIKit

class IncExpPopUpViewController: OverviewViewController, BEMCheckBoxDelegate {
    var entryName = ""
    var entryPrice = ""
    @IBOutlet weak var incomeCheckBox: BEMCheckBox!
    @IBOutlet weak var incomeLabel: UILabel!
    
    
    @IBOutlet weak var expenseCheckBox: BEMCheckBox!
    @IBOutlet weak var expenseLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
            expenseCheckBox.delegate = self
        
        
            incomeCheckBox.delegate = self
        
        
        priceTextField.keyboardType = .numbersAndPunctuation
        priceTextField.delegate = self as UITextFieldDelegate
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        if incomeCheckBox.on == true {
            nameLabel.text = "Income Name"
            nameTextField.placeholder = "Name of Income"
            self.nameTextField.text = entryName
            self.priceTextField.text = entryPrice
            priceLabel.text = "Income Price"
            priceTextField.placeholder = "Price of Income"
            
            expenseLabel.isHidden = true
            expenseCheckBox.isHidden = true
        } else if expenseCheckBox.on == true {
            nameLabel.text = "Expense Name"
            nameTextField.placeholder = "Name of Expense"
            
            priceLabel.text = "Expense Price"
            priceTextField.placeholder = "Price of Expense"
            incomeLabel.isHidden = true
            incomeCheckBox.isHidden = true
        }
    }

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let incomeVC: IncomeViewController = IncomeViewController(nibName: nil, bundle: nil)
        let expenseVC: ExpenseViewController = ExpenseViewController (nibName: nil, bundle: nil)
        let overviewVC: OverviewViewController = OverviewViewController(nibName: nil, bundle: nil)
        
        NotificationCenter.default.post(name: .newIncomeExpense, object: self)
        
        dismiss(animated: true)
        
        if (nameTextField.text!.isEmpty || priceTextField.text!.isEmpty) {
            let alert = UIAlertController(title: "You have to fill out the name and price", message: "Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
        if(priceTextField.text?.count == nil){
            let alert = UIAlertController(title: "NameTextField = nil", message: "NameTextField = nil", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        nameLabel.text = "Name"
        priceLabel.text = "Price"
        
        expenseLabel.isHidden = false
        incomeLabel.isHidden = false
        
        incomeCheckBox.isHidden = false
        incomeCheckBox.on = false
        expenseCheckBox.isHidden = false
        expenseCheckBox.on = false
        
        nameTextField.placeholder = ""
        priceTextField.placeholder = ""
    }
    
}

extension IncExpPopUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
