//
//  User.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 03/06/2025.
//

import Foundation

enum UserType: String, CaseIterable, Codable {
    case admin = "Admin"
    case user = "User"
}

struct User: Codable {
    let fullName: String?
    let username: String
    let password: String
    let email: String?
    let phone: String?
    let userType: UserType
}
