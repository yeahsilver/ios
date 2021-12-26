//
//  first.swift
//  solid_practice
//
//  Created by 허예은 on 2021/12/26.
//

import Foundation

// 단일 책임 원칙: 클래스는 하나의 이유로만 변화해야 한다. 다시 말해 클래스는 한 가지의 책임만 가지고 있어야 한다.
// 사용 전

// 로그인 처리 클래스
class Login {
    func login() {
        print("단일 책임 원칙 처리 전")
        decode() { [weak self] value in
            
            guard let value = value else {
                return
            }
            
            self?.verifyToken(value) { token in
                if(token != nil) {
                    print("로그인 성공")
                } else {
                    print("로그인 실패")
                }
            }
        }

    }
    
    // 책임 1 디코딩
    func decode(_ completed: @escaping (String?) -> Void) {
        completed("dDKsiewWRD48250W");
    }
    
    // 책임 2 로그인 검증
    func verifyToken(_ token: String,  _ completed: @escaping (String?) -> Void) {
        if(!token.isEmpty) {
            completed(token)
        } else {
            completed(nil)
        }
    }
}

// 사용 후
class LoginAfter {
    let decode: Decode
    let verify: Verify
    
    init(decode: Decode, verify: Verify) {
        self.decode = decode
        self.verify = verify
        
        print("단일 책임 원칙 처리 후")
    }
    
    func login() {
        let token = decode.decode()
        let isVerify = verify.verify(token)
        
        if(isVerify) {
            print("로그인 성공")
        } else {
            print("로그인 실패")
        }
    }
}

class Decode {
    func decode() -> String {
        return "dDKsiewWRD48250W"
    }
}

class Verify {
    func verify(_ token: String) -> Bool {
        if(!token.isEmpty) {
            return true
        }
        
        return false
    }
}
