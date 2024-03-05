//
//  ScoreViewModel.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/24.
//

import SwiftUI

class ScoreViewModel: ObservableObject {
    @Published private var ehallDataModel: EhallDataModel {
        didSet {
            autosave()
        }
    }
    
    private let autosaveURL = URL.documentsDirectory.appendingPathComponent("Autosaved.ehalldata")
    
    init() {
        if let data = try? Data(contentsOf: autosaveURL),
           let autoSavedEhallData = try? EhallDataModel(json: data) {
            self.ehallDataModel = autoSavedEhallData
        } else {
            self.ehallDataModel = EhallDataModel.NotLoggedIn
        }
    }
    
    init(ehallDataModel: EhallDataModel) {
        self.ehallDataModel = ehallDataModel
    }
    
    private func autosave() {
        save(to: autosaveURL)
        print("autosaved to \(autosaveURL)")
    }

    private func save(to url: URL) {
        do {
            let data = try ehallDataModel.json()
            try data.write(to: url)
        } catch let error {
            print("Couldn't save \(url): \(error.localizedDescription)")
        }
    }
    
    var isAvailabe: Bool {
        switch self.ehallDataModel {
        case .LoggedInWithScore:
            true
        default:
            false
        }
    }
    
    var isInfoAvailable: Bool {
        switch self.ehallDataModel {
        case .LoggedIn:
            true
        case .LoggedInWithScore:
            true
        default:
            false
        }
    }
    
    var scores: [CourseScore] {
        if case .LoggedInWithScore(_ , _, _, _, let courseScores) = ehallDataModel {
            courseScores
        } else {
            []
        }
    }
    
    var info: UserInfo? {
        switch self.ehallDataModel {
        case .NotLoggedIn:
            nil
        case .LoggedIn(_, _, _, let userInfo):
            userInfo
        case .LoggedInWithScore(_, _, _, let userInfo, _):
            userInfo
        }
    }
    
    // MARK: - Intents
    
    @MainActor
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
    
    @MainActor
    func getScore() async -> Bool {
        do {
            switch self.ehallDataModel {
            case .LoggedIn(let usernameAndPassword, let school, let authToken, let userInfo):
                let courseScores = try await requestCourseScore(authToken, school: school)
                self.ehallDataModel = EhallDataModel.LoggedInWithScore(usernameAndPassword: usernameAndPassword, school: school, authToken: authToken, userInfo: userInfo, courseScores: courseScores)
                debugPrint("get score succedded")
                return true
            case .LoggedInWithScore(let usernameAndPassword, let school, let authToken, let userInfo, _):
                let courseScores = try await requestCourseScore(authToken, school: school)
                self.ehallDataModel = EhallDataModel.LoggedInWithScore(usernameAndPassword: usernameAndPassword, school: school, authToken: authToken, userInfo: userInfo, courseScores: courseScores)
                debugPrint("get score succedded")
                return true
            default:
                // FIXME: - What to do here?
                debugPrint("get score failed")
                return false
            }
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
}
