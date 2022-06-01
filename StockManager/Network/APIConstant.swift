//
//  APIConstant.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 1/6/2565 BE.
//

import Foundation

struct APIConstant {

    static var baseUrl: String {
        #if DEBUG
        return "https://mobileservice.zortout.com/api.aspx"
        #else
        return "https://mobileservice.zortout.com/api.aspx"
        #endif
    }

}
