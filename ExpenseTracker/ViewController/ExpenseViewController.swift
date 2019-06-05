//
//  ExpenseViewController.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 30.05.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//

import UIKit
import CoreData
class ExpenseTableViewCell: UITableViewCell{
    
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
}

class ExpenseViewController: UIViewController, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    var newEntry = [IncomeExpense]()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<IncomeExpense> = IncomeExpense.fetchRequest()
        do {
            let entries = try PersistenceService.context.fetch(fetchRequest)
            self.newEntry = entries
            self.reloadAll()
            NotificationCenter.default.addObserver(forName: .newIncomeExpense, object: nil, queue: OperationQueue.main) { (notification) in
                let IncExpViewController = notification.object as! IncExpPopUpViewController
                let name: String = IncExpViewController.nameTextField.text!
                let price = IncExpViewController.priceTextField.text!
                let entry = IncomeExpense(context: PersistenceService.context)
                entry.name = name
                entry.price = Float(price)! * -1
                if IncExpViewController.expenseCheckBox.on == true && entry.price < 0{
                    PersistenceService.saveContext()
                    self.newEntry.append(entry)
                    self.reloadAll()
                }
            }
        } catch {} 
    }
}

extension ExpenseViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newEntry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ExpenseTableViewCell
        let newEntries = self.newEntry[indexPath.row]
        cell.nameLabel!.text = newEntries.name
        cell.priceLabel!.text = ("€ \(String(format: "%.2f", newEntries.price))")
        cell.nameLabel.textColor = UIColor.red
        cell.priceLabel.textColor = UIColor.red
        
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
    
    
    func reloadAll(){
        tableView?.reloadData()
        
    }
}

