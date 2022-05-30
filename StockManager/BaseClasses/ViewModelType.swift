//
//  ViewModelType.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 8/4/2565 BE.
//

import Foundation

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}
