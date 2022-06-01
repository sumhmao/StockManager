//
//  BaseAPIResponse.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import Foundation

protocol BaseAPIResponse: Codable {
    var res: APIResponse { get }
}

struct APIResponse: Codable {
    let resCode: String?
    let resDesc: String?
    let resDesc2: String?
    let detail: String?
}
