//
//  User.swift
//  TestServer REST API Test
//
//  Created by 김기현 on 2020/07/23.
//  Copyright © 2020 김기현. All rights reserved.
//

import Foundation

struct User: Codable {
    let user: [UserData]
    let ok: Bool
}

struct UserData: Codable {
    var username: String?
    var password: String?
}
