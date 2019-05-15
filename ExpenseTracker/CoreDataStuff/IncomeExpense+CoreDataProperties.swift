//
//  IncomeExpense+CoreDataProperties.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 15.04.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension IncomeExpense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IncomeExpense> {
        return NSFetchRequest<IncomeExpense>(entityName: "IncomeExpense")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Float
    
}
