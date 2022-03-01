//
//  ViewController.swift
//  EventKitPractice
//
//  Created by mac on 2022/02/16.
//

import UIKit
import EventKit

class ViewController: UIViewController {
    let eventStore: EKEventStore = EKEventStore()
    
    var calendars: [EKCalendar] = []
    var events: [EKEvent]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCalendarAuthorizationStatus()
        // Do any additional setup after loading the view.
    }
    
    private func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: .event)
        
        switch status {
        case .notDetermined:
            print("not determined")
            requestAccessToCalendar()
        case .authorized:
            print("authorized")
            loadCalendars()
        case .restricted, .denied:
            print("restricted or denied")
            break
        @unknown default:
            print("default")
            break
        }
    }
    
    private func requestAccessToCalendar() {
        eventStore.requestAccess(to: .event) { [weak self] granted, error in
            if granted {
                DispatchQueue.main.async {
                    self?.loadCalendars()
                }
            }
        }
    }
    
    private func loadCalendars() {
        calendars = eventStore.calendars(for: .event)
        loadEvents()
    }
}

extension ViewController {
    private func loadEvents() {
        let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.locale = Locale(identifier: "ko_KR")
            df.timeZone = TimeZone(identifier: Locale.current.identifier)
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return df
        }()
        
        let startDate = dateFormatter.date(from: "2022-02-16 00:00:00")
        let endDate = dateFormatter.date(from: "2022-02-16 23:59:59")
        
        if let startDate = startDate,
           let endDate = endDate {
                let eventsPredicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)
                self.events = eventStore.events(matching: eventsPredicate).sorted(by: {
                    e1, e2 -> Bool in
                    return e1.startDate.compare(e2.startDate) == ComparisonResult.orderedAscending
                })
                
                print(events)
           }
    }
}

