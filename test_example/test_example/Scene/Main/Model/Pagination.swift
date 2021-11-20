//
//  Pagination.swift
//  test_example
//
//  Created by 허예은 on 2021/11/19.
//

import Foundation

struct Pagination: Codable {
    let count: Int
    let previous: String
    let num_pages: Int
    let next: String
}
