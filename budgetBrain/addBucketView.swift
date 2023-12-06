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
    @State private var amount = 0
    @State private var percent = 0.0
    
    var body: some View {
        Form {
            Section {
                TextField("Bucket name", text: $name)
                TextField("Initial amount", value: $amount, format: .currency(code: "USD"))
                TextField("Percentage of Income", value: $percent, format: .percent)
            }
            
            Section {
                Button("Save") {
                    let newBucket = Bucket(name: name, amount: Decimal(amount), percent: percent)
                    modelContext.insert(newBucket)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    addBucketView()
}
