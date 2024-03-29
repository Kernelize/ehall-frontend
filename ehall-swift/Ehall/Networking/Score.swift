//
//  Score.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/3/3.
//

import Foundation

struct CourseScoreRequest: Codable {
    let semester: String
    let amount: Int
    let isNeedRank: Bool
}

struct CourseScoreResponse: Codable {
    let status: String
    let message: String
    let totalCount: Int
    let data: [CourseScore]?
}

struct CourseScoreRankRequest: Codable {
    let courseID: String
    let classID: String
    let semester: String
}

struct CourseScoreRankResponse: Codable {
    let status: String
    let message: String
    let data: CourseScoreRank?
}
