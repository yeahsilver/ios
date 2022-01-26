//
//  ViewController.swift
//  HealthKit_Test
//
//  Created by mac on 2022/01/26.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    let healthStore = HKHealthStore()
    let typeToShare: HKCategoryType? = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)
    let typeToRead: HKSampleType? = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)
    
    private var sleepData: [HKCategorySample] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        // Do any additional setup after loading the view.
    }
    
    private func configure() {
        if !HKHealthStore.isHealthDataAvailable() {
            requestAuthorization()
        } else {
            retrieveSleepData()
        }
    }
    
    private func requestAuthorization() {
        self.healthStore.requestAuthorization(toShare: Set([typeToShare!]), read: Set([typeToRead!])) { success, error in
            if error != nil {
                print(error)
            } else {
                if success {
                    print("권한 존재 o")
                } else {
                    print("권한 존재 x")
                }
            }
        }
    }
    
    private func retrieveSleepData() {
        let start = Date()
        let end = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart:start, end: end, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: typeToRead!, predicate: nil, limit: 30, sortDescriptors: [sortDescriptor]) { [weak self] (query, sleepResult, error) -> Void in
            if error != nil {
                return
            }
            if let result = sleepResult {
                DispatchQueue.main.async {
                    self?.sleepData = result as? [HKCategorySample] ?? []
                    print(self?.sleepData)
                }
            }
        }
        healthStore.execute(query)
    }
}

