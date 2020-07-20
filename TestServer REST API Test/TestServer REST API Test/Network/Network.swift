//
//  Network.swift
//  TestServer REST API Test
//
//  Created by 김기현 on 2020/07/20.
//  Copyright © 2020 김기현. All rights reserved.
//

import Foundation
import Alamofire

class Network {
    static let shared: Network = Network()
    let baseUrl = "http://localhost:8080/api"
    
    enum API: String {
        case get = "/test/"
        case post = "/test"
    }
    
    func request<Response: Decodable> (api: API,
                                        method: Alamofire.HTTPMethod,
                                        parameters: Parameters? = nil,
                                        encoding: URLEncoding? = nil,
                                        completion handler: @escaping (Response) -> Void) {
        
        let myQueue = DispatchQueue(label: "testQueue", qos: .background, attributes: [.concurrent])
        
        AF.request(baseUrl + api.rawValue, method: method, parameters: parameters).responseDecodable(of: Response.self) { (response) in
            switch response.result {
            case .success(let obj):
                handler(obj)
            case .failure(let err):
                print("Failure Error: \(err)")
            }
        }
    }
}
