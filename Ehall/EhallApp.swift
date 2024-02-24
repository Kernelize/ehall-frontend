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
    @StateObject var score = ScoreViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(score)
        }
//        .modelContainer(container)
        // inject our datamodel here
    }
}
