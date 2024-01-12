//
//  sortedTransactionList.swift
//  budgetBrain
//
//  Created by Isaac D2 on 12/22/23.
//

import SwiftData
import SwiftUI

struct sortedTransactionList: View {
    @Environment (\.modelContext) var modelContext
    @Query var transactions: [Transaction]
    
    var bucket: Bucket
    
    var body: some View {
        List {
            ForEach(transactions) { transaction in
                NavigationLink(destination: transactionDetailView(transaction: transaction)) {
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
            }
            .onDelete(perform: deleteTransaction)
        }
    }
    
    init(sort: SortDescriptor<Transaction>, bucket: Bucket) {
        let name = bucket.name
        
        _transactions = Query(filter: #Predicate {
            $0.bucket?.name == name
        }, sort: [sort])
        
        self.bucket = bucket
    }
    
    func deleteTransaction(at offsets: IndexSet) {
        for offset in offsets {
            let transaction = transactions[offset]
            bucket.amount += transaction.amount
            modelContext.delete(transaction)
        }
    }
}

#Preview {
    let preview = PreviewContainer([Bucket.self, Transaction.self])
    
    preview.add(items: [Transaction(name: "Lifehouse Donation", amount: 15, date: Date.now, bucket: Bucket.dummy), Transaction(name: "Lifehouse Donation", amount: 25, date: Date.distantFuture, bucket: Bucket.dummy)])
    
    return sortedTransactionList(sort: SortDescriptor(\Transaction.date), bucket: Bucket.dummy).modelContainer(preview.container)
}
