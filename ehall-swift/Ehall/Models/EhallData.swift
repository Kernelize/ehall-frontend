//
//  EhallData.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/12.
//

import Foundation
import SwiftData

enum EhallDataModel: Codable {
    case NotLoggedIn
    case LoggedIn (
        usernameAndPassword: UsernameAndPassword,
        school: School,
        authToken: AuthToken,
        userInfo: UserInfo
    )
    case LoggedInWithScore (
        usernameAndPassword: UsernameAndPassword,
        school: School,
        authToken: AuthToken,
        userInfo: UserInfo,
        courseScores: [CourseScore]
    )
}

enum School: Codable {
    case NanjingNormalUniversity
    case YanShanUniversity
    
    func str() -> String {
        switch self {
        case .NanjingNormalUniversity:
            "nnu"
        case .YanShanUniversity:
            "y"
        }
    }
}

struct UsernameAndPassword: Codable {
    let username: String
    let password: String
}

enum UserSex: Codable {
    case male, female
}

enum UserType: Codable {
    case teacher, student
}

struct UserInfo: Codable {
    let username: String
    let userId: String
    let userType: UserType
    let userDepartment: String
    let userSex: UserSex
}

struct CourseScore: Codable, Identifiable {
    let courseName: String
    let examTime: String
    let courseId: String
    let classId: String
    let totalScore: Int
    let gradePoint: String
    let regularScore: String?
    let midScore: String?
    let finalScore: String?
    let regularPercent: String?
    let midPercent: String?
    let finalPercent: String?
    let courseType: String
    let courseCate: String
    let isRetake: String
    let credits: Float
    let gradeType: String
    let semester: String
    let department: String
    
    var id: String {
        courseName
    }
}

@Model
class Expense {
    var authToken: String
    
    init(authToken: String) {
        self.authToken = authToken
    }
}
