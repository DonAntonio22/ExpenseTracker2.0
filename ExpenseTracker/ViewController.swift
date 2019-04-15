//
//  ViewController.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 15.04.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    var newEntry = [IncomeExpense]()
    @IBOutlet weak var addEntry: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addExpense: UIBarButtonItem!
    @IBOutlet weak var totalAmountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<IncomeExpense> = IncomeExpense.fetchRequest()
        do {
            let entries = try PersistenceService.context.fetch(fetchRequest)
            self.newEntry = entries
            self.reloadAll()
        } catch {}
        
    }

    @IBAction func newEntry(_ sender: Any) {        // Function to add new Incomes or Expenses
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
            self.newEntry.append(entry)
            self.reloadAll()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addExpense(_ sender: Any) {
        let alert = UIAlertController(title: "Add Expense", message: nil, preferredStyle: .alert)
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
            entry.price = Float(price)! * (-1)
            PersistenceService.saveContext()
            self.newEntry.append(entry)
            self.reloadAll()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


}


extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newEntry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = newEntry[indexPath.row].name
        cell.detailTextLabel?.text = ("€ \(String(format: "%.2f", newEntry[indexPath.row].price))")
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15.0)
        if newEntry[indexPath.row].price < 0.0 {
            cell.textLabel?.textColor = UIColor.red
            cell.detailTextLabel?.textColor = UIColor.red
        } else {
            cell.textLabel?.textColor = UIColor.green
            cell.detailTextLabel?.textColor = UIColor.green
        }
        
        return cell
    }
    
    func reloadAll(){
        tableView.reloadData()
        let totalAmount = String(format: "%.2f",newEntry.map{$0.price}.reduce(0.0, {x, y in y + x}))
        totalAmountLabel.text = "Current Balances €\(totalAmount)"
    }
}
