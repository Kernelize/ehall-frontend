//
//  ScoreViewModel.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/24.
//

import SwiftUI

class ScoreViewModel: ObservableObject {
    @Published private var ehallData: EhallData = createEhallData()
    
    private static func createEhallData() -> EhallData {
        EhallData()
    }
    
    func loginWithPassword(p: PasswordLoginInfo, s: School) async -> Bool {
        await self.ehallData.loginWithPassword(p: p, s: s)
    }
    
    func refreshAll() async {
        await self.ehallData.refreshAll()
    }
    
    func logout() {
        self.ehallData.logout()
    }
    
    var isAvailabe: Bool {
        self.ehallData.isAvailable
    }
    
    var scores: UserScore {
        self.ehallData.userData!.userScore
    }
    
    var info: UserInfo? {
        self.ehallData.userData!.userInfo
    }
    
}
