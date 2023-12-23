//
//  bucketDetailView.swift
//  budgetBrain
//
//  Created by Isaac D2 on 12/22/23.
//

import SwiftData
import SwiftUI

struct bucketDetailView: View {
    @Environment (\.modelContext) var modelContext
    @Bindable var bucket: Bucket
    
    
    @State private var sortOrder = SortDescriptor(\Transaction.date)
    
    @State private var name = ""
    @State private var amount: Decimal?
    @State private var date = Date.now
    
    @State private var editable = false
    
    var body: some View {
        Form {
            if editable {
                TextField("Name", text: $bucket.name)
                TextField("Details", value: $bucket.percent, format: .percent)
                TextField("Amount", value: $bucket.amount, format: .currency(code: "USD"))
                Button("Done") {
                    editable = false
                }
            } else {
                Text("Income Percentage: \(bucket.percent, format: .percent)")
                Text("Amount in bucket: \(bucket.amount, format: .currency(code: "USD"))")
                Button("Edit") {
                    editable = true
                }
            }
                
            Section("Add a new transaction in \(bucket.name)") {
                TextField("Enter name of transaction", text: $name)
                TextField("Cost", value: $amount, format: .currency(code: "USD"))
                DatePicker("Transaction Date", selection: $date, displayedComponents: .date)
                Button("Add", action: addTransaction)
            }
            
            Section("Transactions") {
                sortedTransactionLists(sort: sortOrder, bucket: bucket)
            }
        }
        .navigationTitle(bucket.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Menu("Sort", systemImage: "arrow.up.arrow.down") {
                Picker("Sort", selection: $sortOrder) {
                    Text("Name")
                        .tag(SortDescriptor(\Transaction.name))
                    Text("Date")
                        .tag(SortDescriptor(\Transaction.date, order: .reverse))
                    Text("Amount")
                        .tag(SortDescriptor(\Transaction.amount, order: .reverse))
                }
                .pickerStyle(.inline)
            }
        }
    }
        
    func addTransaction() {
        guard name.isEmpty == false else { return }
        
        withAnimation {
            let transaction = Transaction(name: name, amount: amount ?? 0.0, date: date)
            transaction.bucket = bucket
            bucket.transactions.append(transaction)
            bucket.amount -= amount ?? 0.0
            name = ""
            amount = 0.0
            date = Date.now
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Bucket.self, configurations: config)
        let example = Bucket(name: "Tithe", amount: 0.0, percent: 10)
        return bucketDetailView(bucket: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
