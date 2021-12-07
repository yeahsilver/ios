//
//  main.swift
//  combine_practice
//
//  Created by 허예은 on 2021/12/05.
//

import Foundation
import Combine

//let postOfficer = CurrentValueSubject<String, Never>("첫번째 소포는 에어팟!")
//let yeahsilver = postOfficer.sink { value in
//    print(value)
//}

//let 우체국아저씨 = Just("한정판 맥북") // Just는 subscriber에게 output을 한번만 출력한 후 완료하는 publisher입니다. (택배 1개)
//
//let yeahsilver = 우체국아저씨.sink { value in
//    print("yeahsilver가 받은 소포는 \(value)입니다!") // 맥북이다!!!!
//}


//let 우체국아저씨 = Just("우체국 아저씨: yeahsilver의 소포는 한정판 맥북입니다!")
//
//let yeahsilver = 우체국아저씨.sink(receiveCompletion: { result in
//    switch result {
//    case .finished:
//        print("yeahsilver: 잘 받았습니다. 감사합니다!")
//    case .failure(let _):
//        print("yeahsilver: 소포가 제대로 안왔어요 ㅠㅠ")
//    }
//}, receiveValue: { value in
//    print(value)
//
//})


//let postOfficer = CurrentValueSubject<String, Never>("첫번째 소포는 에어팟!")
//let yeahsilver = postOfficer.sink { value in
//    print(value)
//}
//
//postOfficer.send("두번째 소포는 맥북!")
//postOfficer.value = "세번째 소포는 애플워치!"

//let movingWalk = PassthroughSubject<String, MovingWalkError>()
//
//let subscriber = movingWalk.sink(receiveCompletion: { completion in
//    switch completion {
//    case .finished:
//        print("무빙워크 개장 시간이 끝났습니다!")
//    case .failure(let error):
//        if error == MovingWalkError.movingWalkBroken {
//            print("무빙워크가 고장났습니다!")
//        } else if error == MovingWalkError.movingWalkRefair {
//            print("무빙워크를 수리하는 중입니다.")
//        }
//    }
//
//}, receiveValue: { value in
//    print(value)
//})
//
//enum MovingWalkError: Error {
//    case movingWalkBroken
//    case movingWalkRefair
//}
//
//movingWalk.send(completion: .failure(MovingWalkError.movingWalkBroken))

//let subscriber = Just(1).map { _ in print(Thread.isMainThread)}
//.receive(on: DispatchQueue.global())
//.map { print(Thread.isMainThread) }
//.sink { _ in print(Thread.isMainThread) }


//DispatchQueue.global().async {
//    subject.send(2)
//    subject.send(4)
//}
//
//print("실행 완료")


//let subject = PassthroughSubject<Int, Never>()
//subject.receive(on: DispatchQueue.global(qos: .background ))
//
//let subscriber = subject.sink { value in
//    print(value)
//}
//
//subject.send(1)
//
//DispatchQueue.global(qos: .background).async {
//    subject.send(2)
//}

//let publisher = CurrentValueSubject<String, Never>("데이터")
//publisher.subscribe(on: DispatchQueue.global())
//    .sink { _ in
//        print("isMainThread?: \(Thread.isMainThread)")
//    }

//let subscriber = Just(1).subscribe(on: DispatchQueue.global())
//    .map { _ in print(Thread.isMainThread) }
//    .sink { print(Thread.isMainThread) }
//
//print(subscriber)

let subject = PassthroughSubject<Int, Never>()

var bag = Set<AnyCancellable>()

subject.sink { value in
    print(value)
}.store(in: &bag)

subject.send(1)
subject.send(2)
