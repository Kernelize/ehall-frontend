//
//  ScoreCardGrid.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct ScoreCardGrid: View {
    @State private var searchText = ""
    let userData: [UserScore.Data]
    var body: some View {
        ScrollView {
            ForEach(userData) { data in
                ScoreCard(data: data)
            }
        }
        .searchable(text: $searchText)
    }
}

