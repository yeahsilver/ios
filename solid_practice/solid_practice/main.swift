//
//  main.swift
//  solid_practice
//
//  Created by 허예은 on 2021/12/26.
//

import Foundation

// 1. 단일 책임 원칙
let loginBefore: Login = Login()
loginBefore.login()

let loginAfter: LoginAfter = LoginAfter(decode: Decode(), verify: Verify())
loginAfter.login()

// 2. 개방/폐쇄원칙: 확장은 클래스의 행동 변화 없이 가능해야한다. (확장에는 열려있고 변경에는 닫혀있어야 한다.)

