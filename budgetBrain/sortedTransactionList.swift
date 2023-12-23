//
//  sortedTransactionList.swift
//  budgetBrain
//
//  Created by Isaac D2 on 12/22/23.
//

import SwiftData
import SwiftUI

struct sortedTransactionLists: View {
    @Environment (\.modelContext) var modelContext
    @Query var transactions: [Transaction]
    
    var body: some View {
        List {
            ForEach(transactions) { transaction in
                HStack {
                    VStack(alignment: .leading) {
                        Text(transaction.name)
                            .font(.headline)
                        Text(transaction.date.formatted(date: .long, time: .omitted))
                    }
                    Spacer()
                    Text(transaction.amount, format: .currency(code: "USD"))
                }
            }
            .onDelete(perform: deleteTransaction)
        }
    }
    
    init(sort: SortDescriptor<Transaction>, bucket: Bucket) {
        let name = bucket.name
        
        _transactions = Query(filter: #Predicate {
            $0.bucket?.name == name
        }, sort: [sort])
    }
    
    func deleteTransaction(at offsets: IndexSet) {
        for offset in offsets {
            let transaction = transactions[offset]
            modelContext.delete(transaction)
        }
    }
}

#Preview {
    sortedTransactionLists(sort: SortDescriptor(\Transaction.date), bucket: Bucket(name: "Test", amount: 100.0, percent: 100.0))
}
