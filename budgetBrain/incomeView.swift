//
//  incomeView.swift
//  budgetBrain
//
//  Created by Isaac D2 on 1/8/24.
//

import SwiftUI

struct incomeView: View {
    @State private var sortOrder = SortDescriptor(\Income.date)
    @State private var showingAddIncomeView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                sortedIncomeList(sort: sortOrder)
            }
            .navigationTitle("Income")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Source")
                                    .tag(SortDescriptor(\Income.source))
                                Text("Date")
                                    .tag(SortDescriptor(\Income.date, order: .reverse))
                                Text("Amount")
                                    .tag(SortDescriptor(\Income.amount, order: .reverse))
                            }
                            .pickerStyle(.inline)
                        }
                        Button("Add Income", systemImage: "plus") {
                            showingAddIncomeView.toggle()
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddIncomeView) {
                addIncomeView()
            }
        }
    }
}


#Preview("With Income Data") {
    let preview = PreviewContainer([Income.self])
    
    let example1 = Income.dummy
    let example2 = Income.dummy
    let example3 = Income.dummy
    
    preview.add(items: [example1, example2, example3])
    
    return incomeView().modelContainer(preview.container)
}
