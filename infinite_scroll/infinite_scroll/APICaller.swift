//
//  APICaller.swift
//  infinite_scroll
//
//  Created by 허예은 on 2021/11/17.
//

import Foundation

protocol APICallerType {
    var isPaginating : Bool { get }
    func fetchData(pagination: Bool, count: Int, completion: @escaping (Result<[String], Error>) -> Void)
}

class APICaller: APICallerType {
    var isPaginating = false
    
    func fetchData(pagination: Bool = false, count: Int, completion: @escaping (Result<[String], Error>) -> Void) {
        if isPaginating {
            isPaginating = true
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2)) {
            let originalData = [
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook",
                "Apple",
                "Google",
                "Facebook"
            ]
            
            completion(.success(self.splitArray(content: originalData, count: count)))
            
            if self.isPaginating {
                self.isPaginating = false
            }
        }
    }
    
    private func splitArray(content: [String], count: Int) -> [String] {
        var num = 0
        
        var temp: [String] = []
        
        for i in (count*10)..<(count*10)+10 {
            guard i < content.count else {
                return temp
            }
            
            temp.insert(contentsOf: content, at: i)
            num += 1
        }
        
        return temp
    }
}
