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
    
    func json() throws -> Data {
        let encoded = try JSONEncoder().encode(self)
        print("ehallDataModel = \(String(describing: String(data: encoded, encoding: .utf8) ?? nil))")
        return encoded
    }
    
    init(json: Data) throws {
        self = try JSONDecoder().decode(EhallDataModel.self, from: json)
    }
}

enum School: Codable {
    case NanjingNormalUniversity
    case YanShanUniversity
    case NanjingUniversityOfAeronauticsAndAstronautics
    
    func str() -> String {
        switch self {
        case .NanjingNormalUniversity:
            "nnu"
        case .YanShanUniversity:
            "ysu"
        case .NanjingUniversityOfAeronauticsAndAstronautics:
            "nuaa"
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
    let userName: String
    let userId: String
    // FIXME: - use enum instead
    let userType: String
    let userDepartment: String
    // FIXME: - use enum instead
    let userSex: String
}

struct CourseScore: Codable, Identifiable {
    let courseName: String
    let examTime: String
    let courseID: String
    let classID: String
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

struct CourseScoreRank: Codable {
    let `class`: Class
    let school: School
    
    struct Class: Codable {
        let rank: Int
        let totalPeopleNum: Int
        let lowScore: Int
        let highScore: Int
        let averageScore: Int
        let numAbove90: Int
        let numAbove80: Int
        let numAbove70: Int
        let numAbove60: Int?
        let numAbove50: Int?
    }
    
    struct School: Codable {
        let rank: Int
        let totalPeopleNum: Int
        let lowScore: Int
        let highScore: Int
        let averageScore: Int
        let numAbove90: Int
        let numAbove80: Int
        let numAbove70: Int
        let numAbove60: Int?
        let numAbove50: Int?
    }
}

struct CourseTable: Codable {
    let arranged: [Arranged]
    let not_arranged: [NotArranged]
    
    struct Arranged: Codable {
        let courseName: String
        let classID: String
        let courseID: String
        let credit: Int
        let creditHour: Int
        let semester: String
        let teacher: String
        let time: String
        let week: String
        let classroom: String
    }
    
    struct NotArranged: Codable {
        let courseName: String
        let classID: String
        let courseID: String
        let credit: Int
        let creditHour: Int
        let semester: String
        let teacher: String
        let week: String
    }
}

@Model
class Expense {
    var authToken: String
    
    init(authToken: String) {
        self.authToken = authToken
    }
}
