//
//  ScoreCard.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct ScoreCard : View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .foregroundColor(Color(red: 240 / 255, green: 243 / 255, blue: 253 / 255))
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
            .padding()
            .overlay {
                VStack(alignment: .leading) {
                    Circle()
                        .frame(width:50, height: 50)
                        .overlay(
                            Image(systemName: "text.book.closed.fill")
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                                .font(.title2)
                    )
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .frame(width: 100, height: 25)
                        .foregroundColor(.gray)
                    VStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .frame(width: 250, height: 15)
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .frame(width: 200, height: 15)
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .frame(width: 290, height: 15)

                    }
                    .foregroundColor(.gray.opacity(0.5))
                }
            }
    }
}

#Preview {
    ScoreCard()
}
