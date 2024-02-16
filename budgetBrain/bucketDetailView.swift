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
    @Environment(\.presentationMode) var presentationMode
    @Bindable var bucket: Bucket
    
    @State private var sortOrder = SortDescriptor(\Transaction.date, order: .reverse)
    
    @State private var editable = false
    @State private var deleteConfirmation = false
    @State private var showingAddTransactionView = false
    
    var body: some View {
        Form {
            if editable {
                Section("Bucket Name") {
                    TextField("Emoji", text: $bucket.emoji)
                    TextField("Name", text: $bucket.name)
                }
                Section("Income Percentage") {
                    Picker("Bucket Percentage", selection: $bucket.percent) {
                        ForEach(0..<101) { number in
                            Text(number, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                Section("Amount currently in bucket") {
                    TextField("Amount", value: $bucket.amount, format: .number)
                }
                Section("Allowed amount") {
                    TextField("Allowed", value: $bucket.allowedAmount, format: .number)
                }
                Section {
                    Button("Done") {
                        editable = false
                    }
                }
            } else {
                Text("\(bucket.emoji) \(bucket.name)")
                Text("Income Percentage: \(bucket.percent, format: .percent)")
                Text("Amount in bucket: \(bucket.amount, format: .currency(code: "USD"))")
                Text("Allowed Amount: \(bucket.allowedAmount, format: .currency(code: "USD"))")
                Button("Edit") {
                    editable = true
                }
            }
            
            Section("Transactions") {
                    sortedTransactionList(sort: sortOrder, bucket: bucket)
            }
        }
        .navigationTitle(bucket.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button("Add Transaction", systemImage: "plus") {
                        showingAddTransactionView.toggle()
                    }
                    if editable {
                        Button("Delete", systemImage: "trash") {
                            deleteConfirmation.toggle()
                        }
                    } else {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Label("Date", systemImage: "calendar.circle")
                                    .tag(SortDescriptor(\Transaction.date, order: .reverse))
                                Label("Name", systemImage: "a.circle")
                                    .tag(SortDescriptor(\Transaction.name))
                                Label("Amount", systemImage: "dollarsign.circle")
                                    .tag(SortDescriptor(\Transaction.amount, order: .reverse))
                            }
                            .pickerStyle(.inline)
                        }
                    }
                }
            }
        }
        .alert("Delete Bucket?", isPresented: $deleteConfirmation) {
            Button("Delete", role: .destructive) {
                modelContext.delete(bucket)
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this bucket?")
        }
        .sheet(isPresented: $showingAddTransactionView) {
            addTransactionView(bucket: bucket)
        }
    }
}

#Preview("No Transactions") {
    let preview = PreviewContainer([Bucket.self])
    
    return bucketDetailView(bucket: Bucket.dummy).modelContainer(preview.container)
}

#Preview("With Transaction Data") {
    let preview = PreviewContainer([Bucket.self])
    
    let example1 = Transaction.dummy
    example1.bucket = Bucket.dummy
    
    let example2 = Transaction.dummy
    example2.bucket = Bucket.dummy
    
    let example3 = Transaction.dummy
    example3.bucket = Bucket.dummy
    
    preview.add(items: [example1, example2, example3])
    
    return bucketDetailView(bucket: Bucket(name: "Test", emoji: "💰", percent: 34)).modelContainer(preview.container)
}
