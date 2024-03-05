//
//  ScoreCard.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct ScoreCard : View {
    @Environment(\.colorScheme) var colorScheme
    
    var backgroundColor: Color {
        switch colorScheme {
        case .dark:
            Color(red: 25 / 255, green: 30 / 255, blue: 60 / 255)
        case .light:
            Color(red: 240 / 255, green: 243 / 255, blue: 253 / 255)
        default:
            Color(red: 240 / 255, green: 243 / 255, blue: 253 / 255)
        }
    }
    
    let score: CourseScore
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundColor(backgroundColor)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "text.book.closed.fill")
                        .aspectRatio(contentMode: .fit)
                        .font(.title2)
                        .padding(4)
                        .bold()
                    Text(score.courseName)
                        .font(.title2)
                        .minimumScaleFactor(0.5)
                        .bold()
                    Spacer()
                }
                Text("TotalScore: \(score.totalScore)")
                    .bold()
                    .font(.title3)
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
            .padding()
        }
    }
}

#Preview {
    ScoreCard(score: PreviewCourseScore)
}
