//
//  ScoreNavigationStack.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct ScoreNavigationStack: View {
    var body: some View {
        NavigationStack {
            ScoreCardGrid()
                .navigationTitle("Score")
        }
    }
}

#Preview {
    ScoreNavigationStack()
}
