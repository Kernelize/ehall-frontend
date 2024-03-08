//
//  HighLightCards.swift
//  Ehall
//
//  Created by Hank on 2024/3/7.
//

import SwiftUI
import Charts

struct TotalScoreHighLightCard: View {
    let score: CourseScore
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Highest total score")
                    .foregroundStyle(.secondary)
                Text(score.courseName)
                    .font(.title2.bold())
                TotalScoreHighLightCardChart(rank: score.courseRank)
                    .frame(height: 100)
            }
        }
    }
}

struct TotalScoreHighLightCardChart: View {
    let rank: CourseScoreRank
    
    var body: some View {
        Chart(rank.schoolScoreArray, id: \.0) { element in
            SectorMark(
                angle: .value("Scores", element.1),
                innerRadius: .ratio(0.618),
                angularInset: 1
            )
            .cornerRadius(3.0)
            .foregroundStyle(by: .value("People", element.0))
            .opacity(element.0 == rank.selfSchoolSection ? 1 : 0.3)
        }
        .chartLegend(.hidden)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
}

#Preview {
    TotalScoreHighLightCard(score: PreviewCourseScore)
        .padding()
}
