//
//  ScoreViewModel.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/24.
//

import SwiftUI

class ScoreViewModel: ObservableObject {
    @Published private var ehallDataModel: EhallDataModel = createEhallDataModel()
    
    private static func createEhallDataModel() -> EhallDataModel {
        EhallDataModel.NotLoggedIn
    }
    
    func login(p: UsernameAndPassword, s: School) async -> Bool {
        do {
            let authToken = try await requestAuthToken(s, p)
            let userInfo = try await requestUserInfo(authToken, school: s)
            self.ehallDataModel = EhallDataModel.LoggedIn(usernameAndPassword: p, school: s, authToken: authToken, userInfo: userInfo)
            return true
        } catch let error {
            debugPrint(error)
            return false
        }
    }
    
    func refreshAll() async {
    }
    
    func logout() {
        self.ehallDataModel = EhallDataModel.NotLoggedIn
    }
    
    var isAvailabe: Bool {
        switch self.ehallDataModel {
        case .LoggedIn:
            true
        default:
            false
        }
    }
    
    var scores: [CourseScore] {
        if case .LoggedInWithScore(let usernameAndPassword, let school, let authToken, let userInfo, let courseScores) = ehallDataModel {
            courseScores
        } else {
            []
        }
    }
    
    var info: UserInfo? {
        switch self.ehallDataModel {
        case .NotLoggedIn:
            nil
        case .LoggedIn(let usernameAndPassword, let school, let authToken, let userInfo):
            userInfo
        case .LoggedInWithScore(let usernameAndPassword, let school, let authToken, let userInfo, let courseScores):
            userInfo
        }
    }
}
