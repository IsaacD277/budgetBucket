//
//  budgetBrainApp.swift
//  budgetBrain
//
//  Created by Isaac D2 on 12/5/23.
//

import SwiftUI

@main
struct budgetBrainApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [Bucket.self, Income.self])
    }
}
