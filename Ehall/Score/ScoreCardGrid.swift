//
//  ScoreCardGrid.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct ScoreCardGrid: View {
    @State private var searchText = ""
    var body: some View {
        ScrollView {
            ForEach(0..<15) { item in
                ScoreCard()
            }
        }
        .searchable(text: $searchText)
    }
}
