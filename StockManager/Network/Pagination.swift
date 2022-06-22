//
//  Pagination.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 22/6/2565 BE.
//

import Foundation

final class Pagination {

    let size: Int
    private(set) var hasNext: Bool = true
    private(set) var page: Int = 0
    private var count = 0
    private(set) var offset: Int = 0

    init(size: Int = 20) {
        self.size = size
    }

    func next() -> Bool {
        guard hasNext else { return false }
        offset = (page * size)
        page += 1
        return true
    }

    func hasNext(count: Int) {
        hasNext = (self.count != count) && (count % size == 0)
        self.count = count
    }

}
