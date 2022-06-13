//
//  Merchant.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import Foundation

struct Merchant: Codable {
    let userId: Int
    let merchantId: Int
    let name: String
    let displayName: String
    let password: String
}
