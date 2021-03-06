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
    let id: Int?
    var title: String?
    var content: String?
    var user: String?
    var time: String?
}
