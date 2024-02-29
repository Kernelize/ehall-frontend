//
//  EhallData.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/12.
//

import Foundation
import SwiftData

struct EhallData {
    var uuid = UUID()
    var userData: UserData?
    
    var isAvailable: Bool {
        self.userData != nil
    }
    
    init() {
        self.userData = nil
    }
    
    mutating func refreshAll() async {
        await refreshUserInfo()
        await refreshUserScore()
    }
    
    // login and refresh the userInfo
    @MainActor
    mutating func loginWithPassword(p: PasswordLoginInfo, s: School) async -> Bool {
        guard let authToken = await requestAuthToken(s, p) else {
            return false
        }
        print("authToken succeed")
        
        guard let userInfo = await requestUserInfo(authToken: authToken.auth_token) else {
            return false
        }
        print("userInfo succeed")

        guard let userScore = await requestUserScore(authToken: authToken.auth_token, scoreRequestInfo: ScoreRequestInfo(semester: "all", amount: 64)) else {
            return false
        }
        print("userScore succeed")
        self.userData = UserData(passwordLoginInfo: p, school: s, authToken: authToken.auth_token, userScore: userScore, userInfo: userInfo)

        print("All succedd, Available: \(self.isAvailable)")
        
        return true
    }
    
    mutating func logout() {
        self.userData = nil
    }
    
    mutating private func refreshUserInfo() async {
        if let res = await requestUserInfo(authToken: self.userData!.authToken) {
            self.userData!.userInfo = res
        }
    }
    
    mutating private func refreshUserScore() async {
        let scoreRequestInfo = ScoreRequestInfo(semester: "all", amount: 64)
        if let res = await requestUserScore(authToken: self.userData!.authToken, scoreRequestInfo: scoreRequestInfo) {
            self.userData!.userScore = res
        }
    }
    
    struct UserData: Codable {
        var passwordLoginInfo: PasswordLoginInfo
        var school: School
        
        var authToken: String
        var userScore: UserScore
        var userInfo: UserInfo
    }
}

@Model
class Expense {
    var authToken: String
    
    init(authToken: String) {
        self.authToken = authToken
    }
}
