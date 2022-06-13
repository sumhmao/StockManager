//
//  GetDashboardStockCategoryEndpoint.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 13/6/2565 BE.
//

import Foundation
import Alamofire

struct GetDashboardStockCategoryEndpoint: Endpoint {

    public static let service = GetDashboardStockCategoryEndpoint()
    private init() {}

    let url: String = "?method=GETDASHBOARDCATEGORYGRAPH&version=2"
    let method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil

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
        let list: [CategoryGraphItem]
        let name: String?
    }

    struct CategoryGraphItem: Codable {
        let id: Int
        let name: String?
        let value: Double
    }

}
