//
//  ReportStockGraphData.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 13/6/2565 BE.
//

import Foundation

struct ReportStockGraphData {

    struct StockGraphItem {
        let id: Int
        let name: String
        let value: Double
    }

    let title: String
    let list: [StockGraphItem]
}
