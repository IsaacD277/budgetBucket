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
    var amount: Decimal
    var percent: Double
    
    @Relationship(deleteRule: .cascade) var transactions = [Transaction]()
    
    init(name: String, amount: Decimal = 0.0, percent: Double = 0) {
        self.name = name
        self.amount = amount
        self.percent = percent
    }
    
    func distributionRule() {
        // Address different rules here
    }
}

extension Bucket {
    static var dummy: Bucket {
        .init(name: "Tithe",
            amount: 250,
              percent: 0.1)
    }
}
