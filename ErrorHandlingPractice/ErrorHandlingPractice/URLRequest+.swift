//
//  URLRequest+.swift
//  Wolley
//
//  Created by mac on 2022/02/01.
//

import Foundation

import RxSwift

extension URLRequest {
    enum ContentType {
        case json
    }
    
    enum HttpMethod: String {
        case GET
        case POST
    }
    
    func setHttpMethod(_ method: HttpMethod) -> Self {
        var request = self
        request.httpMethod = method.rawValue
        return request
    }
    
    func setHttpBody(_ body: Data) -> Self {
        var request = self
        request.httpBody = body
        return request
    }
    
    func setAuthToken(_ token: String) -> Self {
        var request = self
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func setContentType(_ contentType: ContentType) -> Self {
        var request = self
        let value: String
        switch contentType {
        case .json:
            value = "application/json"
        }
        
        request.setValue(value, forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func setHeader(_ key: String, _ value: String) -> Self {
        var request = self
        
        request.setValue(value, forHTTPHeaderField: key)
        return request
    }
    
    func toDataTask<Response: Decodable>() -> Observable<NetworkResult<Response>> {
        return Observable<NetworkResult<Response>>.create { observer in
            let task = URLSession.shared.dataTask(with: self) { data, response, error in
                guard let response = response as? HTTPURLResponse,
                      let data = data
                else { return }
                
                WolleyLog.debug(Response.self, response.statusCode)
                
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(GenericResponse<Response>.self, from: data)
                    
                    WolleyLog.debug(Response.self, decodedData.responseMsg)
                    
                    switch response.statusCode {
                    case 200:
                        observer.onNext(.success(decodedData.data!))
                        
                    case 400..<500:
                        observer.onNext(.requestErr(decodedData.data!))
                        
                    case 500:
                        observer.onNext(.serverErr)
                        
                    default:
                        observer.onNext(.networkFail)
                        
                    }
                } catch {
                    observer.onNext(.pathErr)
                }
            }
            
            task.resume()
            
            return Disposables.create(with: task.cancel)
        }
    }
}
