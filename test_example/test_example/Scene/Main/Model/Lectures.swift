//
//  Lectures.swift
//  test_example
//
//  Created by 허예은 on 2021/11/19.
//

import Foundation

struct Lectures: Codable {
    let pagination: Pagination
    let result: [Lecture]
}
