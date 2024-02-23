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
    var userData: UserData
    
    init(school: School, passwordLoginInfo: PasswordLoginInfo) {
        self.userData = UserData(passwordLoginInfo, school)
    }
    
    mutating func refreshAll() async {
        await refreshUserInfo()
        await refreshUserScore()
    }
    
    // login and refresh the userInfo
    mutating func login() async -> Bool {
        if let res = await requestAuthToken(self.userData.school, self.userData.passwordLoginInfo) {
            self.userData.authToken = res.auth_token
            await refreshUserInfo()
            return true
        } else {
            return false
        }
    }
    
    mutating private func refreshUserInfo() async {
        if let res = await requestUserInfo(authToken: self.userData.authToken!) {
            self.userData.userInfo = res
        }
    }
    
    mutating private func refreshUserScore() async {
        let scoreRequestInfo = ScoreRequestInfo(semester: "all", amount: 64)
        if let res = await requestUserScore(authToken: self.userData.authToken!, scoreRequestInfo: scoreRequestInfo) {
            self.userData.userScore = res
        }
    }
    
    struct UserData: Codable {
        var passwordLoginInfo: PasswordLoginInfo
        var school: School
        
        var authToken: String?
        var userScore: UserScore?
        var userInfo: UserInfo?
        
        init(_ passwordLoginInfo: PasswordLoginInfo, _ school: School) {
            self.school = school
            self.passwordLoginInfo = passwordLoginInfo
        }
    }
}

@Model
class Expense {
    var authToken: String
    
    init(authToken: String) {
        self.authToken = authToken
    }
}
