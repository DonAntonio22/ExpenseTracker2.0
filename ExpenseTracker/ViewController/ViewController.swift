//
//  ViewController.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 15.04.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//

import UIKit
import CoreData

class NewEntryTableViewCell: UITableViewCell{
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
}

class ViewController: UIViewController, UITableViewDelegate {

    var newEntry = [IncomeExpense]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        
        let fetchRequest: NSFetchRequest<IncomeExpense> = IncomeExpense.fetchRequest()
        do {
            let entries = try PersistenceService.context.fetch(fetchRequest)
            self.newEntry = entries
            self.reloadAll()
            
        } catch {}
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: .newIncomeExpense, object: nil, queue: OperationQueue.main) { (notification) in
            let IncExpViewController = notification.object as! IncExpPopUpViewController
            let name: String = IncExpViewController.nameTextField.text!
            let price = IncExpViewController.priceTextField.text!
            let entry = IncomeExpense(context: PersistenceService.context)
            entry.name = name
            entry.price = Float(price)!
            if IncExpViewController.incomeCheckBox.on == true || IncExpViewController.expenseCheckBox.on == true{
                
                PersistenceService.saveContext()
                self.newEntry.append(entry)
                self.reloadAll()
            }
            
            if IncExpViewController.expenseCheckBox.on == true {
                entry.price = Float(price)! * -1
                
            }
            
        }
        
        
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewEntryTableViewCell
        let newEntries = self.newEntry[indexPath.row]
        cell.nameLabel!.text = newEntries.name
        cell.priceLabel!.text = ("€ \(String(format: "%.2f", newEntries.price))")
        if (cell.nameLabel!.text == nil || cell.nameLabel!.text == "\0" || cell.nameLabel!.text == "0"){
            let alert = UIAlertController(title: "CellNameLabel = nil", message: "CellNameLabel = nil", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
        if (cell.priceLabel!.text == nil || cell.priceLabel!.text == "\0" || cell.priceLabel!.text == "0"){
            let alert = UIAlertController(title: "CellPriceLabel = nil", message: "CellPriceLabel = nil", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
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
        
        let totalAmount = String(format: "%.2f",newEntry.map{$0.price}.reduce(0.0, {x, y in y + x}))
        if let totalAmount = totalAmountLabel
        {
            totalAmountLabel.text = "Error because of nil"
        }
        totalAmountLabel?.text = "Current Balance €\(totalAmount)"
        
        
        tableView?.reloadData()
        
        //tableView?.beginUpdates()
        
        //tableView?.endUpdates()
        
    }
}
