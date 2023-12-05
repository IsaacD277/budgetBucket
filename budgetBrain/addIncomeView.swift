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
                        
                        Text(formatCurrency(value: income))
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
    
    // Function to format a Decimal as currency
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency // Set to currency style
        formatter.locale = Locale.current  // Adjusts to the current locale (you can set to specific locale if needed)
        // Convert Decimal to NSNumber
        let number = NSNumber(value: value / Double(buckets.count))
        
        // Format and return the string
        return formatter.string(from: number) ?? "N/A"
    }
    
    // Function to distribute income
    func distributeIncome() {
        let distribution = Decimal(income) / Decimal(buckets.count)
        for bucket in buckets {
            bucket.amount += distribution
        }
            
        // Here, you might need to save the updated buckets back to your model context
    }
}

#Preview {
    AddIncomeView()
}
