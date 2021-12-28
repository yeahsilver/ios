//
//  second.swift
//  solid_practice
//
//  Created by 허예은 on 2021/12/27.
//

import Foundation

// 수정 전
//class Vehicle {
//    func setVehicle() {
//        print("Set Vehicle")
//        let cars = [Car(brand: "Hyudai"),
//                    Car(brand: "KIA"),
//                    Car(brand: "Renault")
//        ]
//
//        let trucks = [Truck(brand: "Hyudai"),
//                      Truck(brand: "KIA")
//        ]
//
//        for car in cars {
//            car.getBrand()
//        }
//
//        for truck in trucks {
//            truck.getBrand()
//        }
//    }
//}
//
//class Car {
//    let brand: String
//
//    init(brand: String) {
//        self.brand = brand
//    }
//
//    func getBrand() {
//        print("car: \(brand)")
//    }
//}
//
//class Truck {
//    let brand: String
//
//    init(brand: String) {
//        self.brand = brand
//    }
//
//    func getBrand() {
//        print("truck: \(brand)")
//    }
//}

// 수정 후
protocol VehicleProtocol {
    func getBrand() -> String
}

class Vehicle {
    func getBrand() {
        let vehicles: [VehicleProtocol] = [
                    Car(brand: "Hyudai"),
                    Car(brand: "KIA"),
                    Car(brand: "Renault"),
                    Truck(brand: "Hyudai"),
                    Truck(brand: "KIA")
        ]
        
        vehicles.forEach { vehicle in
            print(vehicle.getBrand())
        }
    }
}

class Car: VehicleProtocol {
    let brand: String
    
    init(brand: String) {
        self.brand = brand
    }
    
    func getBrand() -> String {
       return brand
    }
}

class Truck: VehicleProtocol {
    let brand: String
    
    init(brand: String) {
        self.brand = brand
    }
    
    func getBrand() -> String{
        return brand
    }
}
