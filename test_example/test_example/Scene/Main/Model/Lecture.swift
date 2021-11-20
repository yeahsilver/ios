//
//  Lecture.swift
//  test_example
//
//  Created by 허예은 on 2021/11/19.
//

import Foundation

struct Lecture: Codable {
    let name: String
    let start: String
    let end: String
    let media: Media
}

struct Media: Codable {
    let course_image: String
}
