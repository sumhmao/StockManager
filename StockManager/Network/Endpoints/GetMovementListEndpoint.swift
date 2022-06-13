//
//  GetMovementListEndpoint.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 13/6/2565 BE.
//

import Foundation
import Alamofire

struct GetMovementListEndpoint: Endpoint {

    public static let service = GetMovementListEndpoint()
    private init() {}

    let url: String = "?method=GETMOVEMENTLIST&version=2"
    let method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil

    struct Request: Codable {
        let userid: Int
        let password: String
        let merchantid: Int
        let movementtype: Int
        let page: Int
        let pagesize: Int

        init(page: Int = 1, pagesize: Int = 20) {
            self.userid = UserContext.shared.merchant?.userId ?? 0
            self.password = UserContext.shared.merchant?.password ?? ""
            self.merchantid = UserContext.shared.merchant?.merchantId ?? 0
            self.movementtype = 1
            self.page = page
            self.pagesize = pagesize
        }

    }

    struct Response: BaseAPIResponse {
        let res: APIResponse
        let list: [MovementItem]
        let name: String?
    }

    struct MovementItem: Codable {

    }

}
