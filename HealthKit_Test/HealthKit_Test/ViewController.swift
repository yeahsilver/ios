import UIKit
import HealthKit

class ViewController: UIViewController {
    
    let healthStore = HKHealthStore()
    let sleepToShare: HKCategoryType? = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)
    let sleepToRead: HKSampleType? = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)
    let distanceToRead: HKSampleType? = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)
    
    private var sleepData:[HKCategorySample] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveSleepData()
        requestAuthorization()
    }
    
    private func configure() {
        if !HKHealthStore.isHealthDataAvailable() {
            print("권한 x")
            requestAuthorization()
        } else {
            print("권한 0")
            requestAuthorization()
            
        }
    }
    
    private func requestAuthorization() {
        self.healthStore.requestAuthorization(toShare: Set([sleepToShare!]), read: Set([sleepToRead!, distanceToRead!])) { [weak self] success, error in
            if error != nil {
                print(error.debugDescription)
            } else{
                if success {
                    print("권한이 허락되었습니다.")
                    self?.retrieveSleepData()
                    self?.retrieveWalkingDistance()
                }else{
                    print("권한이 아직 없어요.")
                }
            }
        }
    }
    
    private func saveSleepData() {
        let start = makeStringToDateWithTime(str: "2022-01-25 10:00")
        let end = makeStringToDateWithTime(str: "2022-01-25 11:00")
        
        let object = HKCategorySample(type: sleepToShare!, value: HKCategoryValueSleepAnalysis.inBed.rawValue, start: start,end: end)
        healthStore.save(object, withCompletion: { [weak self] (success, error) in
            if error != nil {
                return
            }
            if success {
                print("수면 데이터 저장 완료!")
                self?.retrieveSleepData()
                self?.retrieveWalkingDistance()
            } else {
                print("수면 데이터 저장 실패...")
            }
        })
    }
    
    private func retrieveSleepData() {
        let start = makeStringToDate(str: "2022-01-24")
        let end = makeStringToDate(str: "2022-01-27")
        let predicate = HKQuery.predicateForSamples(withStart:start, end: end, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)
        let query = HKSampleQuery(sampleType: sleepToRead!, predicate: predicate, limit: 30, sortDescriptors: [sortDescriptor]) { [weak self] query, sleepResult, error in
            
            if error != nil {
                return
            }
            
            if let result = sleepResult {
                DispatchQueue.main.async {
                    self?.sleepData = result as? [HKCategorySample] ?? []
                    
                    var previousStart: String = ""
                    var previousEnd: String = ""
                    
                    for i in 0..<(self?.sleepData.count)! {
                        let sleep = self?.sleepData[i]
                        let date = self?.dateToString(date: sleep!.startDate)
                        let start = self?.dateToStringOnlyTime(date: sleep!.startDate)
                        let end = self?.dateToStringOnlyTime(date: sleep!.endDate)
                        
                        let currentTimeInterval = sleep!.endDate.timeIntervalSince(sleep!.startDate)
                        print(start, end, currentTimeInterval)
                        
                        if i > 0 {
                            if previousStart == start && previousEnd == end {
                                continue
                            } else {
                                previousStart = start!
                                previousEnd = end!
                                print("\(date!): \(start!) ~ \(end!)")
                            }
                        }
                    }
                }
            }
        }
        
        healthStore.execute(query)
    }
    
    
    private func retrieveWalkingDistance() {
        guard let type = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            fatalError("Something went wrong retriebing quantity type distanceWalkingRunning")
        }
        
        let date = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date)

        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum]) { (query, statistics, error) in
            var value: Double = 0

            if error != nil {
                print("something went wrong")
            } else if let quantity = statistics?.sumQuantity() {
                value = quantity.doubleValue(for: HKUnit.meter())
            }
            
            print(value)
        }
        
        healthStore.execute(query)
    }
    
    private func makeStringToDate(str:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")

        return dateFormatter.date(from: str)!
    }
    
    private func makeStringToDateWithTime(str:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")

        return dateFormatter.date(from: str)!
    }
    
    private func dateToString(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

       return dateFormatter.string(from: date)
    }
    
    private func dateToStringOnlyTime(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

       return dateFormatter.string(from: date)
    }
    
}
