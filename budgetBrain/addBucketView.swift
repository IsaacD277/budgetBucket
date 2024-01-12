//
//  addBucketView.swift
//  budgetBrain
//
//  Created by Isaac D2 on 12/5/23.
//

import SwiftData
import SwiftUI

struct addBucketView: View {
    @Environment (\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var emoji = ""
    @State private var amount: Double?
    @State private var percent: Int?
    @State private var allowedAmount: Decimal?
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter name of bucket", text: $name)
                        .keyboardType(.default)
                    
                    TextField("Enter bucket emoji", text: $emoji)
                        .keyboardType(.default)
                    
                    Picker("Bucket Percentage", selection: $percent) {
                        ForEach(0..<101) { number in
                            Text(number, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    TextField("Initial amount in bucket", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                    TextField("Allowed Amount", value: $allowedAmount, format: .number)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add a Bucket")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", systemImage: "backpack") {
                        let newBucket = Bucket(name: name, emoji: emoji, amount: Decimal(amount ?? 0.0), percent: percent ?? 0, allowedAmount: allowedAmount ?? 100.0)
                        modelContext.insert(newBucket)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    addBucketView()
}
