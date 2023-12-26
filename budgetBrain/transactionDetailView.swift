//
//  transactionDetailView.swift
//  budgetBrain
//
//  Created by Isaac D2 on 12/26/23.
//

import SwiftData
import SwiftUI

struct transactionDetailView: View {
    @Environment (\.modelContext) var modelContext
    @Bindable var transaction: Transaction
    
    @State private var editable = false
    
    var body: some View {
        VStack {
            Text("Transaction Name: \(transaction.name)")
            Text("Transaction Amount: \(transaction.amount, format: .currency(code: "USD"))")
            Text("Transaction Date: \(transaction.date.formatted(date: .complete, time: .omitted))")
            Text("\(transaction.bucket?.name ?? "Not assigned")")
            Text("Transaction Notes: \(transaction.notes)")
        }
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Bucket.self, configurations: config)
//        let example = Bucket(name: "Tithe", amount: 0.0, percent: 10)
//        let exampleTransaction = Transaction(name: "Walmart", amount: 100.00, date: Date.now, notes: "It was such a wonderful experience shopping at Walmart for food to take to the red. It will be a lot of food we get to eat. And we will cook some of it over the campfire too!", bucket: example)
//        return transactionDetailView(transaction: exampleTransaction)
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create model container.")
//    }
//}
