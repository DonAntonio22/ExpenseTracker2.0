//
//  Weak.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 01.06.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//

import Foundation

/// A box that allows us to weakly hold on to an object
struct Weak<Object: AnyObject> {
    weak var value: Object?
}
