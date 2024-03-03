//
//  Auth.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/3/3.
//

import Foundation

struct LoginRequest: Codable {
    let username: String
    let password: String
    
    init(_ u: UsernameAndPassword) {
        self.username = u.username
        self.password = u.password
    }
}

typealias AuthToken = String

struct LoginResponse: Codable {
    let status: String
    let message: String
    let authToken: AuthToken?
}
