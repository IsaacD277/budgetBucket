//
//  addIncomeView.swift
//  budgetBrain
//
//  Created by Isaac D2 on 12/5/23.
//

import SwiftData
import SwiftUI

struct AddIncomeView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Bucket.name)]) var buckets: [Bucket]
    @Environment(\.dismiss) var dismiss
    
    @State private var income = 0.0
    
    var body: some View {
        Form {
            Section {
                TextField("Income", value: $income, format: .currency(code: "USD"))
            }
            
            Section {
                ForEach(buckets, id: \.self) { bucket in
                    HStack {
                        Text(bucket.name)
                        
                        Spacer()
                        
                        Text(income * bucket.percent, format: .currency(code: "USD"))
                    }
                }
            }
            
            Section {
                Button("Save") {
                    distributeIncome()
                    dismiss()
                }
            }
        }
    }
    
    // Function to distribute and save income to each bucket
    func distributeIncome() {
        for bucket in buckets {
            bucket.amount += Decimal(income * bucket.percent)
        }
    }
}

#Preview {
    AddIncomeView()
}
