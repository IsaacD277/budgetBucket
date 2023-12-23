//
//  Transaction.swift
//  budgetBrain
//
//  Created by Isaac D2 on 12/12/23.
//

import Foundation
import SwiftData

@Model
class Transaction {
    let id: UUID
    var name: String
    var amount: Decimal
    var date: Date
    var notes: String

    @Relationship(inverse: \Bucket.transactions) var bucket: Bucket?
    
    init(id: UUID = UUID(), name: String, amount: Decimal, date: Date, notes: String = "", assignedTo: Bucket? = nil) {
        self.id = id
        self.name = name
        self.amount = amount
        self.date = date
        self.notes = notes
        self.bucket = bucket
    }
}
