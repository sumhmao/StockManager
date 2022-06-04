//
//  LoginEndpoint.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import Foundation
import Alamofire

struct LoginEndpoint: Endpoint {

    public static let service = LoginEndpoint()
    private init() {}

    let url: String = "?method=LOGIN&version=2"
    let method: HTTPMethod = .post
    var headers: HTTPHeaders? = nil

    struct Request: Codable {
        let username: String
        let password: String
    }

    struct Response: BaseAPIResponse {
        let res: APIResponse
        let userid: Int
        let merchantid: Int
        let displayname: String?
        let merchantname: String?
        let userrole: UserRole?
    }

    struct UserRole: Codable {
        let id: Int
        let no: Int
        let name: String?
    }

}
