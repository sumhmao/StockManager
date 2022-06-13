//
//  ReportMovementData.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 13/6/2565 BE.
//

import Foundation

struct ReportMovementData {

    struct MovementItem {
        let id: String
        let title: String
        let imageUrl: String?
        let movement: String
        let available: String
        let lastItem: Bool
    }

    let title: String
    let list: [MovementItem]
}
