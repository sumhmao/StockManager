//
//  ProductItemDisplayViewModel.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 21/6/2565 BE.
//

import Foundation

struct ProductItemDisplayViewModel {
    let id: String
    let title: String
    let imageUrl: String?
    let stock: Int
    let available: Int
    let deleted: Bool
}
