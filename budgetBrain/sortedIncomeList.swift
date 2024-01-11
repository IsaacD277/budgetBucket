//
//  sortedIncomeList.swift
//  budgetBrain
//
//  Created by Isaac D2 on 1/6/24.
//

import SwiftData
import SwiftUI

struct sortedIncomeList: View {
    @Environment (\.modelContext) var modelContext
    @Query var incomes: [Income]
    
    var body: some View {
        List {
            ForEach(incomes) { income in
                NavigationLink(destination: incomeDetailView(income: income)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(income.source)
                                .font(.headline)
                            Text(income.date.formatted(date: .long, time: .omitted))
                        }
                        Spacer()
                        Text(income.amount, format: .currency(code: "USD"))
                    }
                }
            }
            .onDelete(perform: deleteIncome)
        }
    }
    
    init(sort: SortDescriptor<Income>) {
        _incomes = Query(sort: [sort])
    }
    
    func deleteIncome(at offsets: IndexSet) {
        for offset in offsets {
            let income = incomes[offset]
            modelContext.delete(income)
        }
    }
}

#Preview {
    let preview = PreviewContainer([Income.self])
    
    preview.add(items: [Income.dummy])
    
    return sortedIncomeList(sort: SortDescriptor(\Income.date))
        .modelContainer(preview.container)
}
