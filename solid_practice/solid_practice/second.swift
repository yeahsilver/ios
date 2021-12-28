//
//  second.swift
//  solid_practice
//
//  Created by 허예은 on 2021/12/27.
//

import Foundation

class Vehicle {
    func setVehicle() {
        print("Set Vehicle")
        let cars = [Car(brand: "Hyudai"),
                    Car(brand: "KIA"),
                    Car(brand: "Renault")
        ]
        
        let trucks = [Truck(brand: "Hyudai"),
                      Truck(brand: "KIA")
        ]
        
        for car in cars {
            car.getCarName()
        }
        
        for truck in trucks {
            truck.getCarName()
        }
    }
}

class Car {
    let brand: String
    
    init(brand: String) {
        self.brand = brand
    }
    
    func getCarName() {
        print("car: \(brand)")
    }
}

class Truck {
    let brand: String
    
    init(brand: String) {
        self.brand = brand
    }
    
    func getCarName() {
        print("truck: \(brand)")
    }
}
