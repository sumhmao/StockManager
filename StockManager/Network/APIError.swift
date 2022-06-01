//
//  APIError.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import Foundation

struct APIError: LocalizedError {

    public var code: String
    public var message: String

    init(code: String, message: String) {
        self.code = code
        self.message = message
    }

    public var errorDescription: String? {
        return message
    }

}
