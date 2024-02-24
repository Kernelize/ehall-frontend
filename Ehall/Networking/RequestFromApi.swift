//
//  RequestFromApi.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/12.
//

import Foundation
import Alamofire

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

struct PasswordLoginInfo: Codable {
    let username: String
    let password: String
}
struct AuthToken: Codable {
    let auth_token: String
    let message: String
    let status: String
}

struct UserScore: Codable {
    let status: String
    let message: String
    let totalCount: Int?
    let data: [Data]?
    struct Data: Codable, Identifiable {
        let courseName: String
        let examTime: String
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
}

struct ScoreRequestInfo: Codable {
    let semester: String
    let amount: Int
}

struct UserInfo: Codable {
    let status: String
    let message: String
    let data: Data?
    struct Data: Codable {
        let userName: String
        let userId: String
        let userType: String
        let userDepartment: String
        let userSex: String
    }
}

fileprivate let backendHost = "http://47.115.205.46:8080"

func testLogin() async {
    let loginInfo = PasswordLoginInfo(username: "21220513", password: "283511")
    let school = School.NanjingNormalUniversity
    
    let authToken = await requestAuthToken(school, loginInfo)!
    debugPrint(authToken)
    let scoreRequestInfo = ScoreRequestInfo(semester: "all", amount: 64)
    let userScore = await requestUserScore(authToken: authToken.auth_token, scoreRequestInfo: scoreRequestInfo)
    debugPrint(userScore)
}

func testRequestAuthToken() async -> String? {
    let loginInfo = PasswordLoginInfo(username: "21220513", password: "283511")
    let school = School.NanjingNormalUniversity
    
    if let authToken = await requestAuthToken(school, loginInfo) {
        return authToken.auth_token
    }
    return nil
}

func requestAuthToken(_ school: School, _ loginInfo: PasswordLoginInfo) async -> AuthToken? {
    let requestAuthTokenUrl = backendHost + "/" + school.str() + "/cas_login"
    let response = AF.request(requestAuthTokenUrl, method: .post, parameters: loginInfo, encoder: JSONParameterEncoder.default).serializingDecodable(AuthToken.self)
    return try? await response.value
}

func requestUserInfo(authToken: String) async -> UserInfo? {
    let requestUserInfoUrl = backendHost + "/nnu/user/info"
    var headers: HTTPHeaders = [.accept("application/json")]
    headers.add(.authorization(authToken))
    let response = AF.request(requestUserInfoUrl, headers: headers).serializingDecodable(UserInfo.self)
    return try? await response.value
}

func requestUserScore(authToken: String, scoreRequestInfo: ScoreRequestInfo) async -> UserScore? {
    let requestScoreUrl = backendHost + "/nnu/user/score"
    var headers: HTTPHeaders = [.accept("application/json")]
    headers.add(.authorization(authToken))
    
    let response = AF.request(requestScoreUrl, method: .post, parameters: scoreRequestInfo, encoder: JSONParameterEncoder.default, headers: headers).serializingDecodable(UserScore.self)
    return try? await response.value
}

import SwiftUI
import SwiftData

struct TestView: View {
    var body: some View {
        VStack {
            Button("get") {
                Task {
                    let authToken = await testRequestAuthToken()
                    print(authToken)
                }
            }
        }
    }
}

struct Networking_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
