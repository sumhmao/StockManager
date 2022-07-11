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

    let urlMethod: String = "FORGOTPASSWORD"
    let method: HTTPMethod = .post
    var headers: HTTPHeaders? = nil
    var urlParams: [String : String]? = nil

    struct Request: Codable {
        let email: String
    }

    struct Response: BaseAPIResponse {
        let res: APIResponse
    }

}
