//
//  MainViewModel.swift
//  test_example
//
//  Created by 허예은 on 2021/11/19.
//

import Combine
import Foundation

protocol MainViewModelType {
    var listSubject: CurrentValueSubject<Lectures?, Never> { get }
    func List()
}

class MainViewModel: MainViewModelType {
    private var service: MainServiceType
    private var fetchSubscription: AnyCancellable?
    
    var listSubject = CurrentValueSubject<Lectures?, Never>(nil)
    
    init(service: MainServiceType) {
        self.service = service
        List()
    }
    
    deinit {
        Log.debug(Self.self, #function)
    }
    
    func List() {
        fetchSubscription = service.requestLecture().sink (
        receiveCompletion: { completion in
            switch completion {
            case .finished:
                Log.debug("finished completion")
                   
            case .failure(let error):
                Log.error(error)
            }
                    
        },  receiveValue: { response in
                Log.debug(response.pagination.count)
                self.listSubject.send(response)
        })
    }
}

