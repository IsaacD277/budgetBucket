//
//  PreviewContainer.swift
//  budgetBrain
//
//  Created by Isaac D2 on 12/26/23.
//  Sourced from this YouTube video: https://www.youtube.com/watch?v=jCC3yuc5MUI
//

import Foundation
import SwiftData

struct PreviewContainer {
    let container: ModelContainer!

    init(_ types: [any PersistentModel.Type], isStoredInMemoryOnly: Bool = true) {
        let schema = Schema(types)
        let config = ModelConfiguration(isStoredInMemoryOnly: isStoredInMemoryOnly)
        self.container = try! ModelContainer(for: schema, configurations: [config])
    }
    
    func add(items: [any PersistentModel]) {
        Task { @MainActor in
            items.forEach { container.mainContext.insert($0) }
        }
            
    }
}
