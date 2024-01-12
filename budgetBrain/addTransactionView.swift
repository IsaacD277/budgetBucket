//
//  addTransactionView.swift
//  budgetBrain
//
//  Created by Isaac D2 on 1/10/24.
//

import SwiftUI

struct addTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var bucket: Bucket
    
    @State private var name = ""
    @State private var amount: Decimal?
    @State private var date = Date.now
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter name of transaction", text: $name)
                    TextField("Cost", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                    DatePicker("Transaction Date", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("New Transaction")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        addTransaction()
                        dismiss()
                    }
                }
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
            amount = nil
            date = Date.now
        }
    }
}

#Preview {
    let preview = PreviewContainer([Bucket.self])
    
    return addTransactionView(bucket: Bucket.dummy).modelContainer(preview.container)
}
