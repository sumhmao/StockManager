//
//  GetProductListEndpoint.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 21/6/2565 BE.
//

import Foundation
import Alamofire

struct GetProductListEndpoint: Endpoint {

    public static let service = GetProductListEndpoint()
    private init() {}

    let url: String = "?method=GETPRODUCTLIST&version=2&isquicksearch=1"
    let method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil

    struct Request: Codable {
        let userid: Int
        let password: String
        let merchantid: Int
        let quicksearchtext: String?
        let page: Int
        let pagesize: Int

        init(searchText: String?, pagination: Pagination) {
            self.userid = UserContext.shared.merchant?.userId ?? 0
            self.password = UserContext.shared.merchant?.password ?? ""
            self.merchantid = UserContext.shared.merchant?.merchantId ?? 0
            self.quicksearchtext = searchText
            self.page = pagination.page
            self.pagesize = pagination.size
        }
    }

    struct Response: BaseAPIResponse {
        let res: APIResponse
        let product: [Product]
    }

    struct Product: Codable {
        let id: Int?
        let code: String?
        let categoryid: Int?
        let name: String?
        let description: String?
        let barcode: String?
        let sellprice: Double?
        let stock: Double?
        let availablestock: Double?
        let categoryname: String?
        let imagepath: String?
        let unittext: String?
        let isdeleted: Int?
    }

}
