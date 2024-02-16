//
//  ListView.swift
//  budgetBrain
//
//  Created by Isaac D2 on 1/1/24.
//

import SwiftData
import SwiftUI

struct listView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Bucket.name)]) var buckets: [Bucket]
    
    var body: some View {
        ScrollView {
            ForEach(buckets) { bucket in
                NavigationLink {
                    bucketDetailView(bucket: bucket)
                } label: {
                    VStack {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .background(Color(red: 0.38, green: 0.61, blue: 0.54))
                                .cornerRadius(10)
                            GeometryReader { geometry in
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: geometry.size.width * CGFloat(bucket.spendingPercentage / 100))
                                    .background(Color(red: 0.59, green: 0.93, blue: 0.83))
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            }
                            HStack {
                                Text(bucket.emoji)
                                Text(bucket.name)
                                    .bold()
                                    .foregroundColor(Color(red: 0.14, green: 0.24, blue: 0.30))
                                
                                Spacer()
                                
                                Text("\(bucket.amount, format: .currency(code: "USD")) / \(bucket.allowedAmount, format: .currency(code: "USD"))")
                                    .foregroundColor(Color(red: 0.14, green: 0.24, blue: 0.30))
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(red: 0.14, green: 0.24, blue: 0.30))
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 38)
                    }
                }
            }
        }
    }
}

#Preview("With Data") {
    let preview = PreviewContainer([Bucket.self])
    preview.add(items: [Bucket(name: "Tithe", emoji: "⛪️", amount: 25.0, percent: 10, allowedAmount: 100.0), Bucket(name: "Investment", emoji: "💰", amount: 50, percent: 5, allowedAmount: 500.0)])
    return listView().modelContainer(preview.container)
}
