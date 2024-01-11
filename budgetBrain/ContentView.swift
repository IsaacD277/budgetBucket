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
    @State private var showingIncomeList = false
    
    func totalAmount() -> Decimal {
        var sum: Decimal = 0.0
        
        for bucket in buckets {
            sum += bucket.amount
        }
        return sum
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                listView()
                    .padding()
            }
            .navigationTitle("Buckets \(totalAmount(), format: .currency(code: "USD"))")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Income", systemImage: "plus") {
                        showingAddIncomeView.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Add Bucket", systemImage: "pencil") {
                        showingAddBucketView.toggle()
                        // modelContext.insert(Bucket(name: "Just a test"))
                    }
                }
            }
            .sheet(isPresented: $showingAddBucketView) {
                addBucketView()
            }
            .sheet(isPresented: $showingAddIncomeView) {
                addIncomeView()
            }
        }
    }
}

#Preview("Empty") {
    ContentView()
}

#Preview("With Data") {
    let preview = PreviewContainer([Bucket.self, Income.self])
    preview.add(items: [Bucket(name: "Tithe", amount: 64.00, percent: 10), Bucket(name: "Investment", amount: 20.00, percent: 5), Income(amount: 100.0, date: Date.now, source: "Dominion Broadcasting, Inc."), Income.dummy])
    return ContentView().modelContainer(preview.container)
}
