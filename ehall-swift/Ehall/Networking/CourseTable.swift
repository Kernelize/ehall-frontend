//
//  CourseTable.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/3/3.
//

import Foundation

struct CourseTableRequest: Codable {
    let semester: String
}

struct CourseTableResponse: Codable {
    let message: String
    let status: String
    let data: CourseTable?
}
