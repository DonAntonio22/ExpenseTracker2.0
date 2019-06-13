//
//  IncomeViewController.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 30.05.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//

import UIKit
import CoreData


class IncomeTableViewCell: UITableViewCell {
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
}

class IncomeViewController: UIViewController, UITableViewDelegate {
    
    var cellValue = 0
    private let refreshControl = UIRefreshControl()
    var myData = [IncomeExpense]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<IncomeExpense> = IncomeExpense.fetchRequest()
        do {
            let entries = try PersistenceService.context.fetch(fetchRequest)
            self.myData = entries
            self.reloadAll()
            
        } catch {}
        tableView.separatorStyle = .none    //Entfernt Trennstrich zwischen Einträgen in Tabelle
        NotificationCenter.default.addObserver(forName: .newIncomeExpense, object: nil, queue: OperationQueue.main) { (notification) in
            let IncExpVC = notification.object as! IncExpPopUpViewController
            let name: String = IncExpVC.nameTextField.text!
            let price = IncExpVC.priceTextField.text!
            let entry = IncomeExpense(context: PersistenceService.context)
            entry.name = name
            entry.price = Float(price)! * 1
            if IncExpVC.incomeCheckBox.on == true && entry.price > 0.0{
                self.myData.append(entry)
                self.reloadAll()
            }
        }
    
    }
}
    
extension IncomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! IncomeTableViewCell
        
        let newEntries = self.myData[indexPath.row]
        if newEntries.price > 0{
            cell.nameLabel!.text = newEntries.name
            cell.priceLabel!.text = ("€ \(String(format: "%.2f", newEntries.price))")
            cell.nameLabel.textColor = UIColor.green
            cell.priceLabel.textColor = UIColor.green
            tableView.rowHeight = 63.0
            return cell
        }
        tableView.rowHeight = 0
        
       
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let rowHeight: CGFloat = 63.0
        return rowHeight
    }

    
    func reloadAll(){
        tableView?.reloadData()
 
    }
}


