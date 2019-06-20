//
//  IncExpPopUpViewController.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 16.04.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//

import UIKit
import CoreData

class IncExpPopUpViewController: UIViewController, BEMCheckBoxDelegate {
    var entryName = ""
    var entryPrice = ""
    @IBOutlet weak var backgroundView: UIView!
    
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
    
    var myData = [IncomeExpense]()
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
        NotificationCenter.default.post(name: .newIncomeExpense, object: self)
        
        dismiss(animated: true)
        
        
        
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

/*extension IncExpPopUpViewController: Themed{
    func applyTheme(_ theme: AppTheme) {
        view.backgroundColor = theme.backgroundColor
        incomeCheckBox.backgroundColor = theme.backgroundColor
        incomeLabel.textColor = theme.textColor
        expenseCheckBox.backgroundColor = theme.backgroundColor
        expenseLabel.textColor = theme.backgroundColor
        nameLabel.textColor = theme.textColor
        nameTextField.textColor = theme.textColor
        nameTextField.backgroundColor = theme.backgroundColor
        priceLabel.textColor = theme.textColor
        priceTextField.backgroundColor = theme.backgroundColor
        priceTextField.textColor = theme.textColor
        backgroundView.backgroundColor = theme.backgroundColor
    }
}*/
