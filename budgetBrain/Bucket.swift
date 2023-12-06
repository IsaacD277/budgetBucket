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
    
    init(name: String, amount: Decimal, percent: Double) {
        self.name = name
        self.amount = amount
        self.percent = percent
    }
    
    func distributionRule() {
        // Address different rules here
    }
}
