//
//  InsertProductEndpoint.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 12/7/2565 BE.
//

import Foundation
import Alamofire

struct InsertProductEndpoint: Endpoint {

    public static let service = InsertProductEndpoint()
    private init() {}

    let urlMethod: String = "INSERTPRODUCT"
    let method: HTTPMethod = .post
    var headers: HTTPHeaders? = nil
    var urlParams: [String : String]? = [
        "userid": "\(UserContext.shared.merchant?.userId ?? 0)",
        "password": "\(UserContext.shared.merchant?.password ?? "")",
        "merchantid": "\(UserContext.shared.merchant?.merchantId ?? 0)"
    ]

    struct Request: Codable {
        let code: String
        let name: String
        let purchaseprice: Double
        let sellprice: Double
        let barcode: String?

        init(code: String, name: String, purchaseprice: Double, sellprice: Double, barcode: String? = nil) {
            self.code = code
            self.name = name
            self.purchaseprice = purchaseprice
            self.sellprice = sellprice
            self.barcode = barcode
        }
    }

    struct Response: BaseAPIResponse {
        let res: APIResponse
    }

}
