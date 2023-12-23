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
    @State private var showingAddTransactionView = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(buckets) { bucket in
                        NavigationLink(value: bucket) {
                            HStack {
                                Text(bucket.name)
                                
                                Spacer()
                                
                                Text(bucket.amount, format: .currency(code: "USD"))
                            }
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
            .navigationTitle("Buckets")
            .navigationDestination(for: Bucket.self) { bucket in
                bucketDetailView(bucket: bucket)
            }
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
                addIncomeView()
            }
        }
    }
    
    func deleteBuckets(at offsets: IndexSet) {
        for offset in offsets {
            let bucket = buckets[offset]
            modelContext.delete(bucket)
        }
    }
}

#Preview {
    ContentView()
}
