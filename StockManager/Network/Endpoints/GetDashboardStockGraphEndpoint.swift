//
//  GetDashboardStockGraphEndpoint.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 13/6/2565 BE.
//

import Foundation
import Alamofire

struct GetDashboardStockGraphEndpoint: Endpoint {

    public static let service = GetDashboardStockGraphEndpoint()
    private init() {}

    let urlMethod: String = "GETDASHBOARDSTOCKGRAPH"
    let method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil
    var urlParams: [String : String]? = nil

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
        let list: [StockGraphItem]
        let name: String?
    }

    struct StockGraphItem: Codable {
        let id: Int
        let name: String?
        let value: Double
    }

}
