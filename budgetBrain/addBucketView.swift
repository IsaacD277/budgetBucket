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
    @State private var amount: Double?
    @State private var percent: Double?
    
    @FocusState private var isFieldOneFocused: Bool
    @FocusState private var isFieldTwoFocused: Bool
    @FocusState private var isFieldThreeFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter name of bucket", text: $name)
                        .keyboardType(.default)
                        .submitLabel(.next)
                        .focused($isFieldOneFocused)
                        .onAppear(perform: {
                            isFieldOneFocused = true
                        })
                    
                    TextField("Enter percentage of income", value: $percent, format: .percent)
                        .keyboardType(.decimalPad)
                        .focused($isFieldTwoFocused)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                if isFieldTwoFocused {
                                    Spacer()
                                    Button("Next") {
                                        isFieldTwoFocused = false
                                        isFieldThreeFocused = true
                                    }
                                }
                            }
                        }
                    
                    TextField("Initial amount in bucket", value: $amount, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFieldThreeFocused)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                if isFieldThreeFocused {
                                    Spacer()
                                    Button("Done") {
                                        isFieldThreeFocused = false
                                    }
                                }
                            }
                        }
                } .onSubmit {
                    if isFieldOneFocused {
                                    isFieldOneFocused = false
                                    isFieldTwoFocused = true
                                } else if isFieldTwoFocused {
                                    isFieldTwoFocused = false
                                    isFieldThreeFocused = true
                                }
                }
            }
            .navigationTitle("Add a Bucket")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", systemImage: "backpack") {
                        let newBucket = Bucket(name: name, amount: Decimal(amount ?? 0.0), percent: percent ?? 0.0)
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
