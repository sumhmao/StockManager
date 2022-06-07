//
//  ForgotPasswordEndpoint.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 7/6/2565 BE.
//

import Foundation
import Alamofire

struct ForgotPasswordEndpoint: Endpoint {

    public static let service = ForgotPasswordEndpoint()
    private init() {}

    let url: String = "?method=FORGOTPASSWORD&version=2"
    let method: HTTPMethod = .post
    var headers: HTTPHeaders? = nil

    struct Request: Codable {
        let email: String
    }

    struct Response: BaseAPIResponse {
        let res: APIResponse
    }

}
