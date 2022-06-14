//
//  ReportSalesGraphData.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 15/6/2565 BE.
//

import Foundation

struct ReportSalesGraphData {

    struct SalesGraphItem {
        struct ValueItem {
            let detailId: Int
            let name: String
            let value: Double
        }

        let name: String
        let value1: String
        let value2: String
        let valueList: [ValueItem]
    }

    let title: String
    let list: [SalesGraphItem]
}
