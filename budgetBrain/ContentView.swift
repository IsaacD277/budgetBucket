//
//  ContentView.swift
//  budgetBrain
//
//  Created by Isaac D2 on 12/5/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Bucket.name)]) var buckets: [Bucket]
    
    @State private var showingAddBucketView = false
    @State private var showingAddIncomeView = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(buckets) { bucket in
                        HStack {
                            Text(bucket.name)
                            
                            Spacer()
                            
                            Text(formatCurrency(bucket.amount))
                        }
                    }
                    .onDelete(perform: deleteBuckets)
                }
                
                Section {
                    Button("Add Bucket") {
                        showingAddBucketView.toggle()
                    }
                }
            }
            .navigationTitle("Bucket Overview")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Income", systemImage: "plus") {
                        showingAddIncomeView.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddBucketView) {
                addBucketView()
            }
            .sheet(isPresented: $showingAddIncomeView) {
                AddIncomeView()
            }
        }
    }
    
    func deleteBuckets(at offsets: IndexSet) {
        for offset in offsets {
            let bucket = buckets[offset]
            modelContext.delete(bucket)
        }
    }
    
    // Function to format a Decimal as currency
    func formatCurrency(_ value: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency // Set to currency style
        formatter.locale = Locale.current  // Adjusts to the current locale (you can set to specific locale if needed)
        // Convert Decimal to NSNumber
        let number = NSDecimalNumber(decimal: value)
            
        // Format and return the string
        return formatter.string(from: number) ?? "N/A"
    }
}

#Preview {
    ContentView()
}
