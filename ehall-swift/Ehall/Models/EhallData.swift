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
    let rank: CourseScoreRank
    
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
        let numBelow60: Int?
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
        let numBelow60: Int?
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

extension [CourseScore] {
    var maxTotalScore: CourseScore? {
        self.max(by: { $0.totalScore < $1.totalScore })
    }
    
    var courseCount: Int {
        self.count
    }
    
    var isRetakingCount: Int {
        self.filter{ $0.isRetake != "初修" }.count
    }
    
    var estimateTotalScore: Float? {
        if self.isEmpty {
            return nil
        }
        let x = self.reduce(0.0) { $0 + Float($1.gradePoint)! * Float($1.totalScore) }
        let y = self.reduce(0.0) { $0 + Float($1.gradePoint)! }
        return x / y
    }
    
    var estimateTotalCredit: Float? {
        if self.isEmpty {
            return nil
        }
        let x = self.reduce(0.0) { $0 + Float($1.gradePoint)! * $1.credits }
        let y = self.reduce(0.0) { $0 + Float($1.gradePoint)! }
        return x / y
    }
}

extension CourseScoreRank {
    var schoolScoreArray: [(Int, Int)] {
        var x: Array<(Int, Int)> = []
        x += [
            (90, self.school.numAbove90),
            (80, self.school.numAbove80),
            (70, self.school.numAbove70)
        ]
        if let numAbove60 = self.school.numAbove60,
           let numBelow60 = self.school.numBelow60
        {
            x += [
                (60, numAbove60),
                (0, numBelow60)
            ]
        } else {
            let n = self.school.totalPeopleNum - (self.school.numAbove90 + self.school.numAbove80 + self.school.numAbove70)
            x += [(0, n)]
        }
        
        return x
    }
    
    var selfSchoolSection: Int {
        var rank = self.school.rank
        rank -= self.school.numAbove90
        if rank <= 0 {
            return 90
        }
        rank -= self.school.numAbove80
        if rank <= 0 {
            return 80
        }
        rank -= self.school.numAbove70
        if rank <= 0 {
            return 70
        }
        if let numAbove60 = self.school.numAbove60,
           let numBelow60 = self.school.numBelow60
        {
            rank -= numAbove60
            if rank <= 0 {
                return 60
            }
        }
        return 0
    }
}
