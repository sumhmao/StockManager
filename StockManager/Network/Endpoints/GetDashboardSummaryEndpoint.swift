//
//  GetDashboardSummaryEndpoint.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 15/6/2565 BE.
//

import Foundation
import Alamofire

struct GetDashboardSummaryEndpoint: Endpoint {

    public static let service = GetDashboardSummaryEndpoint()
    private init() {}

    let urlMethod: String = "GETDASHBOARDSUMMARY"
    let method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil
    var urlParams: [String : String]? = [
        "movementtype": "1"
    ]

    struct Request: Codable {
        let userid: Int
        let password: String
        let merchantid: Int

        init() {
            self.userid = UserContext.shared.merchant?.userId ?? 0
            self.password = UserContext.shared.merchant?.password ?? ""
            self.merchantid = UserContext.shared.merchant?.merchantId ?? 0
        }
    }

    struct Response: BaseAPIResponse {
        let res: APIResponse
        let name1: String?
        let name1value: String?
        let name1id: Int?
        let name2: String?
        let name2value: String?
        let name2id: Int?
        let name3: String?
        let name3value: String?
        let name3id: Int?
        let name4: String?
        let name4value: String?
        let name4id: Int?
    }

}
