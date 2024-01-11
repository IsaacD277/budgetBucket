//
//  MainView.swift
//  budgetBrain
//
//  Created by Isaac D2 on 1/8/24.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ContentView()
                .tabItem {
                    Image(systemName: "archivebox")
                    Text("Buckets")
                }
                .tag(1)
            
            incomeView()
                .tabItem {
                    Label(
                        title: { Text("Income") },
                        icon: { Image(systemName: "menucard") }
                    )
                }
                .tag(2)
        }
    }
}

#Preview {
    let preview = PreviewContainer([Bucket.self, Income.self])
    
    let example1 = Income.dummy
    example1.amount = 150
    example1.source = "Example 1"
    
    let example2 = Income.dummy
    example2.date = Date.distantPast
    example2.amount = 125
    example2.source = "Example 2"
    
    let example3 = Income.dummy
    example3.date = Date.distantFuture
    example3.source = "Example 3"
    example3.amount = 500
    
    preview.add(items: [example1, example2, example3])
    
    preview.add(items: [Bucket(name: "Tithe", amount: 64.00, percent: 10), Bucket(name: "Investment", amount: 20.00, percent: 5), Income(amount: 105.0, date: Date.now, source: "Dominion Broadcasting, Inc."), Income.dummy])
    
    return MainView().modelContainer(preview.container)
}
