//
//  ArrayExtensions.swift
//  ExpenseTracker
//
//  Created by Antonio Laštro on 01.06.19.
//  Copyright © 2019 Antonio Laštro. All rights reserved.
//

import Foundation

extension Array {
    /// Move the last element of the array to the beginning
    ///  - Returns: The element that was moved
    mutating func rotate() -> Element? {
        guard let lastElement = popLast() else {
            return nil
        }
        insert(lastElement, at: 0)
        return lastElement
    }
}
