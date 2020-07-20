//
//  TestData.swift
//  TestServer REST API Test
//
//  Created by 김기현 on 2020/07/20.
//  Copyright © 2020 김기현. All rights reserved.
//

import Foundation

struct Data: Codable {
    let data: [TestData]
    let ok: Bool
}

struct TestData: Codable, Hashable {
    let id: Int
    let title: String
    let content: String
    let user: String
    let time: String
}
