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
    private var count = 0

    var offset: Int {
        return page * size
    }
    var page: Int {
        return (count / size) + 1
    }

    init(size: Int = 20) {
        self.size = size
    }

    func hasNext(count: Int) {
        hasNext = (self.count != count) && (count % size == 0)
        self.count = count
    }

}
