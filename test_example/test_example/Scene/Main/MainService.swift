//
//  MainService.swift
//  test_example
//
//  Created by 허예은 on 2021/11/19.
//

import Combine
import Foundation

protocol MainServiceType {
    func requestLecture() -> AnyPublisher<Lectures, Error>
}

class MainService: MainServiceType {
    func requestLecture() -> AnyPublisher<Lectures, Error> {
        let url = URL(string: "http://apis.data.go.kr/B552881/kmooc/courseList?serviceKey=LwG%2BoHC0C5JRfLyvNtKkR94KYuT2QYNXOT5ONKk65iVxzMXLHF7SMWcuDqKMnT%2BfSMP61nqqh6Nj7cloXRQXLA%3D%3D&Mobile=1")
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let httpBody = try? JSONSerialization.data(withJSONObject: [], options: [])
        urlRequest.httpBody = httpBody
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(
                type: Lectures.self,
                decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
