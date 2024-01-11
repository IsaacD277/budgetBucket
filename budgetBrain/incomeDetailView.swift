//
//  incomeDetailView.swift
//  budgetBrain
//
//  Created by Isaac D2 on 1/8/24.
//

import SwiftUI

struct incomeDetailView: View {
    @Environment (\.modelContext) var modelContext
    @Bindable var income: Income
    
    @State private var editable = false
    
    var body: some View {
        List {
            Text(income.amount, format: .currency(code: "USD"))
            Text(income.date.formatted(date: .complete, time: .omitted))
            Text(income.source)
        }
        .navigationTitle(income.source)
    }
}

#Preview {
    let preview = PreviewContainer([Income.self])
    
    return incomeDetailView(income: Income.dummy).modelContainer(preview.container)
}
