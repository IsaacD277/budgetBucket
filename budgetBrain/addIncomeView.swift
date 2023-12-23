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
    
    @State private var income: Double?
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Image(systemName: "dollarsign.circle")
                        TextField("Enter Paycheck Amount", value: $income, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    }
                }
                
                Section {
                    ForEach(buckets, id: \.self) { bucket in
                        HStack {
                            Text(bucket.name)
                            
                            Spacer()
                            
                            Text(Double(income ?? 0.0) * bucket.percent, format: .currency(code: "USD"))
                        }
                    }
                }
            }
            .navigationTitle("Paycheck Distribution")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Distribute", systemImage: "arrow.triangle.branch") {
                        distributeIncome()
                        amountIsFocused = false
                        dismiss()
                    }
                }
            }
        }
        .onAppear(perform: {
            amountIsFocused = true
        })
    }
    
    // Function to distribute and save income to each bucket
    func distributeIncome() {
        for bucket in buckets {
            bucket.amount += Decimal(income ?? 0.0) * Decimal(bucket.percent)
        }
    }
}

#Preview {
    addIncomeView()
}
