//
//  ViewController.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 15.04.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import LocalAuthentication

class NewEntryTableViewCell: UITableViewCell{
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    
}



class OverviewViewController: UIViewController {

    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plusButton: UIBarButtonItem!
    var myData = [IncomeExpense]()
    
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    //TouchID, FaceID Stuff Start
    var context = LAContext()
    enum AuthenticationState {
        case loggedIn, loggedOut
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        var state = AuthenticationState.loggedOut
        if state == AuthenticationState.loggedOut {
            tableView.isHidden = true
            totalAmountLabel.isHidden = true
            context = LAContext()
            context.localizedCancelTitle = "Enter Username/Password"
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                
                let reason = "Log in to your account"
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                    
                    if success {
                       
                        // Move to the main thread because a state update triggers UI changes.
                        DispatchQueue.main.async { [unowned self] in
                            state = .loggedIn
                            self.tableView.isHidden = false
                            self.totalAmountLabel.isHidden = false
                        }
                        
                    } else {
                        print(error?.localizedDescription ?? "Failed to authenticate")
                        
                        // Fall back to a asking for username and password.
                        // ...
                    }
                }
            } else {
                print(error?.localizedDescription ?? "Can't evaluate policy")
                
                // Fall back to a asking for username and password.
                // ...
            }
        }
        
        

        tableView?.separatorStyle = .none    //Entfernt Trennstrich zwischen Einträgen in Tabelle
        let fetchRequest: NSFetchRequest<IncomeExpense> = IncomeExpense.fetchRequest()
        do {
            
            let entries = try PersistenceService.context.fetch(fetchRequest)
            self.myData = entries
            self.reloadAll()
            NotificationCenter.default.addObserver(forName: .newIncomeExpense, object: nil, queue: OperationQueue.main) { (notification) in
                let IncExpViewController = notification.object as! IncExpPopUpViewController
                let name: String = IncExpViewController.nameTextField.text!
                let price = IncExpViewController.priceTextField.text!
                let entry = IncomeExpense(context: PersistenceService.context)
                entry.name = name
                entry.price = Float(price)! * 1
                if IncExpViewController.expenseCheckBox.on == true || IncExpViewController.incomeCheckBox.on == true {
                    if IncExpViewController.expenseCheckBox.on == true{
                        entry.price = Float(price)! * -1
                    }
                    PersistenceService.saveContext()
                    self.myData.append(entry)
                    self.reloadAll()
                }
            }
        } catch {}
    }

    

    
    @IBAction func plusButtonpressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add Entry", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Price"
            textField.keyboardType = .numbersAndPunctuation
        }
        let action = UIAlertAction(title: "Save", style: .default) { (_) in
            let name = alert.textFields!.first!.text!
            let price = alert.textFields!.last!.text!
            let entry = IncomeExpense(context: PersistenceService.context)
            entry.name = name
            entry.price = Float(price)!
            PersistenceService.saveContext()
            self.myData.append(entry)
            self.reloadAll()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}



extension OverviewViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewEntryTableViewCell
        let newEntries = myData[indexPath.row]
        cell.nameLabel!.text = newEntries.name
        cell.priceLabel!.text = ("€ \(String(format: "%.2f", newEntries.price))")
        if newEntries.price < 0.0 {
            cell.nameLabel.textColor = UIColor.red
            cell.priceLabel.textColor = UIColor.red
        } else {
            cell.nameLabel.textColor = UIColor.green
            cell.priceLabel.textColor = UIColor.green
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        if indexPath.row % 2 == 0 {
            cellHeight = 20
        }
        else if indexPath.row % 2 != 0 {
            cellHeight = 63
        }
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Incomes and Expenses"
    }
    
    func reloadAll(){
        let totalAmount = String(format: "%.2f",myData.map{$0.price}.reduce(0.0, {x, y in y + x}))
        if let totalAmount = totalAmountLabel
        {
            totalAmountLabel.text = "Error because of nil"
        }
        totalAmountLabel?.text = "Current Balance €\(totalAmount)"
        tableView?.reloadData()
        
        
    }
}





