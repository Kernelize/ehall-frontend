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
    
    let data: UserScore.Data
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
                    Text(data.courseName)
                        .font(.title2)
                        .minimumScaleFactor(0.5)
                        .bold()
                    Spacer()
                }
                Text("TotalScore: \(data.totalScore)")
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
    ScoreCard(data: UserScore.Data(courseName: "毛泽东思想和中国特色社会主义理论体系", examTime: "2022-0-0", totalScore: 100, gradePoint: "5.0", regularScore: "100", midScore: "100", finalScore: "100", regularPercent: "100", midPercent: "100", finalPercent: "100", courseType: "必修课", courseCate: "必修课", isRetake: "初修", credits: 100, gradeType: "Unknown", semester: "2022-0-0", department: "电气与自动化工程学院"))
}
