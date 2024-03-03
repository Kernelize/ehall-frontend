//
//  Info.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/3/3.
//

import Foundation

struct UserInfoRequest: Codable {}

struct UserInfoResponse: Codable {
    let status: String
    let message: String
    let data: UserInfo?
}
