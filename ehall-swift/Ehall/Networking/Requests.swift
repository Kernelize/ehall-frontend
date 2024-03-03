//
//  Requests.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/12.
//

import Foundation
import Alamofire

fileprivate let backendHost = "http://47.115.205.46:8080"

func requestAuthToken(_ school: School, _ loginInfo: UsernameAndPassword) async throws -> AuthToken {
    let requestAuthTokenUrl = backendHost + "/" + school.str() + "/cas_login"
    let response = AF.request(requestAuthTokenUrl, method: .post, parameters: loginInfo, encoder: JSONParameterEncoder.default).serializingDecodable(LoginResponse.self)
    let loginResponse = try await response.value
    if let authToken = loginResponse.authToken {
        return authToken
    } else {
        throw RequestError(status: loginResponse.status, message: loginResponse.message)
    }
}

func requestUserInfo(_ authToken: AuthToken, school: School) async throws -> UserInfo {
    let requestUserInfoUrl = backendHost + "/" + school.str() + "/user/info"
    var headers: HTTPHeaders = [.accept("application/json")]
    headers.add(.authorization(authToken))
    let response = AF.request(requestUserInfoUrl, headers: headers).serializingDecodable(UserInfoResponse.self)
    let userInfoResponse = try await response.value
    if let userInfo = userInfoResponse.data {
        return userInfo
    } else {
        throw RequestError(status: userInfoResponse.status, message: userInfoResponse.message)
    }
}

func requestCourseScore(_ authToken: AuthToken, school: School, semester: String, amount: Int) async throws -> [CourseScore] {
    let requestScoreUrl = backendHost + "/" + school.str() + "/user/score"
    let courseScoreRequest = CourseScoreRequest(semester: semester, amount: amount)
    var headers: HTTPHeaders = [.accept("application/json")]
    headers.add(.authorization(authToken))
    
    let response = AF.request(requestScoreUrl, method: .post, parameters: courseScoreRequest, encoder: JSONParameterEncoder.default, headers: headers).serializingDecodable(CourseScoreResponse.self)
    let courseScoreResponse = try await response.value
    if let courseScores = courseScoreResponse.data {
        return courseScores
    } else {
        throw RequestError(status: courseScoreResponse.status, message: courseScoreResponse.message)
    }
}

struct RequestError: Error {
    let status: String
    let message: String
}

import SwiftUI
import SwiftData

struct TestView: View {
    var body: some View {
        VStack {
            let vs = VStack {
                if true {
                    Text("hello")
                }
                Rectangle()
                    .frame(width: 100, height: 100)
            }
            Button("get") {
                Task {
                    // await testLogin()
                    print(Mirror(reflecting: vs).subjectType)
                    print(rustGreeting(name: "Swift"))
                }
            }
        }
    }
}

func testLogin() async {
}

func testRequestAuthToken() async -> String? {
    return nil
}

struct Networking_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
