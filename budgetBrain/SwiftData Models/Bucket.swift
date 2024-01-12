//
//  Bucket.swift
//  budgetBrain
//
//  Created by Isaac D2 on 12/5/23.
//

import Foundation
import SwiftData

@Model
class Bucket {
    var name: String
    var emoji: String
    var amount: Decimal
    var percent: Int
    var allowedAmount: Decimal
    
    @Relationship(deleteRule: .cascade) var transactions = [Transaction]()
    
    init(name: String, emoji: String, amount: Decimal = 0.0, percent: Int = 0, allowedAmount: Decimal = 100) {
        self.name = name
        self.emoji = emoji
        self.amount = amount
        self.percent = percent
        self.allowedAmount = allowedAmount
    }
    
    var spendingPercentage: Double { // Computed property for the spending percentage
        let decimalPercentage = NSDecimalNumber(decimal: (amount / allowedAmount) * 100)
        return decimalPercentage.doubleValue
    }
    
    func distributionRule() {
        // Address different rules here
    }
}

extension Bucket {
    static var dummy: Bucket {
        .init(name: "Tithe",
              emoji: "⛪️",
              amount: 250,
              percent: 1,
              allowedAmount: 100.0)
    }
}
