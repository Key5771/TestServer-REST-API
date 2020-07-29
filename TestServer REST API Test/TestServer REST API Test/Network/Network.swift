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
    let myQueue = DispatchQueue(label: "testQueue", qos: .background, attributes: .concurrent)
    
    enum API: String {
        case getData = "/test/"
        case postData = "/test"
        case regist = "/user/"
        case login = "/user/login"
        case logout = "/user/logout"
    }
    
    func response<Response: Decodable> (api: API,
                                        method: Alamofire.HTTPMethod,
                                        parameters: Int? = nil,
                                        encoding: URLEncoding? = nil,
                                        completion handler: @escaping (Response) -> Void) {
        
        if let params = parameters {
            AF.request(baseUrl + api.rawValue + String(params), method: method).responseDecodable(of: Response.self, queue: myQueue) { (res) in
                switch res.result {
                case .success(let obj):
                    print("parameter is not nil")
                    handler(obj)
                case .failure(let err):
                    print("Error: \(err)")
                }
            }
        } else {
            AF.request(baseUrl + api.rawValue,
                       method: method,
                       parameters: parameters)
                .responseDecodable(of: Response.self, queue: myQueue) { (response) in
                    
                    switch response.result {
                    case .success(let obj):
                        print("parameter is nil")
                        handler(obj)
                    case .failure(let err):
                        print("Failure Error: \(err)")
                    }
            }
        }
    }
    
    // Post Data Function
    func request<Request: Codable>(api: API,
                                   method: Alamofire.HTTPMethod,
                                   parameters: Request? = nil,
                                   completion handler: @escaping (Request?, Error?) -> Void) {
        
        AF.request(baseUrl + api.rawValue,
                   method: method,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default)
            .responseDecodable(of: Request.self, queue: myQueue) { (response) in
                
                switch response.result {
                case .success(_):
                    handler(nil, nil)
                case .failure(let err):
                    print("Error getting POST: \(err)")
                    handler(nil, err)
                }
        }
    }
}
