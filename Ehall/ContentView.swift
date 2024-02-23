//
//  ContentView.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/12.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selection: AppScreen? = .home
    var body: some View {
        AppTabView(selection: $selection)
    }
}

struct ContentView_Preview: PreviewProvider {
//    static let container: ModelContainer = {
//        let schema = Schema([EhallData.self])
//        let container = try! ModelContainer(for: schema, configurations: [])
//        return container
//    }()
    
    static var previews: some View {
        ContentView()
//            .modelContainer(container)
    }
}
