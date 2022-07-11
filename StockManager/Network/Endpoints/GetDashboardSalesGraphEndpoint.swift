//
//  GetDashboardSalesGraphEndpoint.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 15/6/2565 BE.
//

import Foundation
import Alamofire

struct GetDashboardSalesGraphEndpoint: Endpoint {

    public static let service = GetDashboardSalesGraphEndpoint()
    private init() {}

    let urlMethod: String = "GETDASHBOARDSALESGRAPH"
    let method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil
    var urlParams: [String : String]? = [
        "type": "1",
        "graphcount": "0"
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
        let list: [SalesGraphItem]
        let name: String?
    }

    struct SalesGraphItem: Codable {
        let name: String
        let value1: String
        let value2: String
        let valuelist: [ValueListItem]
    }

    struct ValueListItem: Codable {
        let detailid: Int
        let name: String
        let value: Double
    }

}
