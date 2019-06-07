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
    var myData = [IncomeExpense]()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none    //Entfernt Trennstrich zwischen Einträgen in Tabelle
        let fetchRequest: NSFetchRequest<IncomeExpense> = IncomeExpense.fetchRequest()
        do {
            let entries = try PersistenceService.context.fetch(fetchRequest)
            self.myData = entries
            self.reloadAll()
            
        } catch {}
        
        
    }
 
    
}

extension ExpenseViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return myData.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ExpenseTableViewCell
        
        let newEntries = self.myData[indexPath.row]
        if newEntries.price < 0{
            cell.nameLabel!.text = newEntries.name
            cell.priceLabel!.text = ("€ \(String(format: "%.2f", newEntries.price))")
            cell.nameLabel.textColor = UIColor.red
            cell.priceLabel.textColor = UIColor.red
            tableView.rowHeight = 63.0
            return cell
        }
        tableView.rowHeight = 0
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight: CGFloat = 63.0
        tableView.reloadData()
        return rowHeight
    }
    
    
    func reloadAll(){
        tableView?.reloadData()
        
    }
}

extension UITableView {
    
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.tableFooterView = UIView()
        
    }
}
