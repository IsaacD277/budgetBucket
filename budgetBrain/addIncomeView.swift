//
//  addIncomeView.swift
//  budgetBrain
//
//  Created by Isaac D2 on 12/5/23.
//

import SwiftData
import SwiftUI

struct addIncomeView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Bucket.name)]) var buckets: [Bucket]
    @Environment(\.dismiss) var dismiss
    
    @State private var income: Decimal?
    @State private var source = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Image(systemName: "dollarsign.circle")
                        TextField("Enter Paycheck Amount", value: $income, format: .number)
                            .keyboardType(.decimalPad)
                    }
                    TextField("Source", text: $source)
                }
                
                Section {
                    ForEach(buckets, id: \.self) { bucket in
                        HStack {
                            Text(bucket.name)
                            
                            Spacer()
                            
                            Text((income ?? 0.0) * Decimal(bucket.percent) / 100.0, format: .currency(code: "USD"))
                        }
                    }
                }
            }
            .navigationTitle("Paycheck Distribution")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Distribute", systemImage: "arrow.triangle.branch") {
                        distributeIncome()
                        modelContext.insert(Income(amount: income ?? 0.0, date: Date.now, source: source))
                        dismiss()
                    }
                }
            }
        }
    }
    
    // Function to distribute and save income to each bucket
    func distributeIncome() {
        for bucket in buckets {
            bucket.amount += (income ?? 0.0) * Decimal(bucket.percent) / 100
        }
    }
}

#Preview("Empty") {
    addIncomeView()
}

#Preview("With Data") {
    let preview = PreviewContainer([Bucket.self])
    preview.add(items: [Bucket(name: "Tithe", emoji: "⛪️", amount: 0.0, percent: 10), Bucket(name: "Investment", emoji: "💰", amount: 200, percent: 5)])
    return addIncomeView().modelContainer(preview.container)
}
