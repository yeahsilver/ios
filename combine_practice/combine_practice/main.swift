//
//  main.swift
//  combine_practice
//
//  Created by 허예은 on 2021/12/05.
//

import Foundation
import Combine

let publisher = Just("yeeun")

let subscriber = publisher.sink { value in
    print(value)
}

