//
//  EhallApp.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/12.
//

import SwiftUI
import SwiftData

@main
struct EhallApp: App {
    
    let container: ModelContainer = {
        let schema = Schema([Expense.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
        // inject our datamodel here
    }
}
