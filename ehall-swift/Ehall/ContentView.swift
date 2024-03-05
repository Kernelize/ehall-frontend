//
//  ContentView.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/12.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selection: AppScreen? = .score
    var body: some View {
        AppTabView(selection: $selection)
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PreviewScoreViewModel)
        ContentView()
            .environmentObject(ScoreViewModel())
    }
}
