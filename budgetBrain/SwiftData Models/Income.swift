//
//  Income.swift
//  budgetBrain
//
//  Created by Isaac D2 on 1/6/24.
//

import Foundation
import SwiftData

@Model
class Income {
    let id: UUID
    var amount: Decimal
    var date: Date
    var source: String
    
    @Relationship var buckets = [Bucket]()
    
    init(id: UUID = UUID(), amount: Decimal, date: Date, source: String) {
        self.id = id
        self.amount = amount
        self.date = date
        self.source = source
    }
}

extension Income {
    static var dummy: Income {
        .init(id: UUID(), amount: 100.0, date: Date.now, source: "This is just some dummy data.")
    }
}

